# shellcheck shell=zsh
#
# Resolve secrets at shell startup using the Keeper Secrets Manager CLI (ksm).
# Secrets are never stored in the repository; instead, the notation for each
# value is read from environment variables or a local mapping file and resolved
# on demand via `ksm secret notation`.

if ! command -v ksm >/dev/null 2>&1; then
  print -u2 "[keeper-secrets] ksm CLI not found; skipping secret exports."
  return 0 2>/dev/null || true
fi

# Collect Keeper notation references from environment variables and optional
# configuration files without leaking values into the repository.
typeset -A _ksm_notations

typeset -a _ksm_expected_keys
_ksm_expected_keys=(
  CLOUDFLARE_API_KEY
  CLOUDFLARE_EMAIL
  NPM_TOKEN
  VAULT_ADDR
)

for _ksm_key in $_ksm_expected_keys; do
  typeset _notation_var="KSM_NOTATION_${_ksm_key}"
  typeset _notation_value="${(P)_notation_var:-}"
  if [[ -n "$_notation_value" ]]; then
    _ksm_notations[$_ksm_key]="$_notation_value"
  fi
done

unset _ksm_expected_keys
unset _notation_var
unset _notation_value

# Support a simple KEY=keeper://... mapping file that lives outside of the repo.
typeset _ksm_map_file="${KSM_NOTATION_FILE:-$HOME/.config/ksm/env-map}"
if [[ -r "$_ksm_map_file" ]]; then
  while IFS='=' read -r _ksm_key _ksm_notation; do
    _ksm_key="${_ksm_key#${_ksm_key%%[![:space:]]*}}"
    _ksm_key="${_ksm_key%${_ksm_key##*[![:space:]]}}"
    _ksm_notation="${_ksm_notation#${_ksm_notation%%[![:space:]]*}}"
    _ksm_notation="${_ksm_notation%${_ksm_notation##*[![:space:]]}}"
    [[ -z "$_ksm_key" ]] && continue
    [[ "$_ksm_key" == '#'* ]] && continue
    if [[ -n "$_ksm_notation" ]]; then
      _ksm_notations[$_ksm_key]="$_ksm_notation"
    fi
  done <"$_ksm_map_file"
fi
unset _ksm_map_file

# Export each secret if it is not already set. Existing exports always win so
# that ad-hoc overrides remain possible for tooling and CI runs.
for _ksm_key _ksm_notation in ${(kv)_ksm_notations}; do
  if [[ -z "$_ksm_notation" ]]; then
    continue
  fi

  if [[ -n "${(P)_ksm_key}" ]]; then
    continue
  fi

  typeset _ksm_value
  _ksm_value="$(ksm secret notation "$_ksm_notation" 2>/dev/null)"
  _ksm_status=$?
  if [[ $_ksm_status -eq 0 && -n "$_ksm_value" ]]; then
    export "${_ksm_key}=${_ksm_value}"
  else
    print -u2 "[keeper-secrets] Failed to resolve $_ksm_key from $_ksm_notation"
  fi
  unset _ksm_value
done

unset _ksm_key
unset _ksm_notation
unset _ksm_notations
