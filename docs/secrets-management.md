# Secrets management

This repository no longer relies on Git clean/smudge filters to hydrate secrets.
Instead, login shells fetch credentials at runtime with the Keeper Secrets
Manager CLI (`ksm`). This document explains how to configure Keeper, how to map
secrets to environment variables, and how to extend the setup for other vaults
such as HashiCorp Vault or 1Password.

## Keeper Secrets Manager

1. **Install the CLI**

   ```shell
   pip install keeper-secrets-manager-cli
   # or use your package manager if it packages the CLI
   ```

2. **Configure access**

   Run `ksm config init` (or `ksm config` for an interactive wizard) and follow
   the prompts to link the CLI with your Keeper Secrets Manager application.
   The configuration is stored locally under `~/.keeper/` and is not tracked by
   Git.

3. **Create a notation map**

   Secrets are resolved through Keeper's notation strings (for example,
   `keeper://<record_uid>/field/password`). The Zsh profile code looks for
   notations in either environment variables or a local mapping file:

   * **Environment variables** – set `KSM_NOTATION_<ENV_NAME>` before launching
     the shell. Example:

     ```shell
     export KSM_NOTATION_CLOUDFLARE_API_KEY="keeper://abc123/field/password"
     export KSM_NOTATION_VAULT_ADDR="keeper://def456/custom_field/url"
     ```

   * **Mapping file** – create `~/.config/ksm/env-map` (or point
     `KSM_NOTATION_FILE` to another location) with simple `KEY=notation` lines.
     Comment lines beginning with `#` are ignored.

     ```ini
     # ~/.config/ksm/env-map
     CLOUDFLARE_API_KEY=keeper://abc123/field/password
     CLOUDFLARE_EMAIL=keeper://abc123/field/login
     NPM_TOKEN=keeper://ghi789/custom_field/token
     VAULT_ADDR=keeper://jkl012/field/url
     ```

4. **Verify the integration**

   Open a new login shell or run `source ~/.config/zsh/profile.d/keeper-secrets.zsh`
   and then check that the expected environment variables are present:

   ```shell
   echo "$CLOUDFLARE_API_KEY"
   echo "$VAULT_ADDR"
   ```

   If a secret cannot be resolved, a warning is printed to stderr during shell
   startup so you can update the notation mapping.

## Integrating work secrets

Keeper covers personal credentials. For employer-managed secrets, you can add
companion scripts in `~/.config/zsh/profile.d/` to pull from the relevant vault
without committing anything sensitive.

### HashiCorp Vault

1. **Authenticate** – ensure `vault login` works for your organisation. The
   `vault-login` alias defined in `.zshrc` expects `VAULT_ADDR` to be populated
   (which Keeper can do), but you may also export it manually in a Vault-specific
   script if you keep the value outside Keeper.

2. **Create a loader script** – save the following template as
   `~/.config/zsh/profile.d/vault-secrets.zsh` and adjust the paths/fields to
   match your Vault layout. The script is ignored by Git but will be sourced at
   login time.

   ```zsh
   # shellcheck shell=zsh
   # Example: hydrate AWS credentials from Vault at shell startup.
   if command -v vault >/dev/null 2>&1; then
     if [[ -z "$AWS_ACCESS_KEY_ID" ]]; then
       export AWS_ACCESS_KEY_ID="$(vault kv get -field=access_key secret/data/aws/dev)"
     fi
     if [[ -z "$AWS_SECRET_ACCESS_KEY" ]]; then
       export AWS_SECRET_ACCESS_KEY="$(vault kv get -field=secret_key secret/data/aws/dev)"
     fi
   fi
   ```

3. **Optional: sync into Keeper** – if you prefer a single integration point,
   Vault secrets can be synchronised into Keeper using `ksm sync`. Once synced,
   reference the new records via notation as described above.

### 1Password (op CLI)

1. **Authenticate** – sign in with the 1Password CLI so `op account list` and
   `op read` work on your machine.

2. **Create a loader script** – drop the following example in
   `~/.config/zsh/profile.d/op-secrets.zsh` and tailor the item paths to your
   vault. The script fetches values using 1Password Connect-style notation and
   exports them for the shell session.

   ```zsh
   # shellcheck shell=zsh
   if command -v op >/dev/null 2>&1; then
     if [[ -z "$SOME_SERVICE_TOKEN" ]]; then
       export SOME_SERVICE_TOKEN="$(op read 'op://Work/SOME SERVICE/api token')"
     fi
     if [[ -z "$SLACK_WEBHOOK" ]]; then
       export SLACK_WEBHOOK="$(op read 'op://Work/Slack Webhook/url')"
     fi
   fi
   ```

3. **Leverage Keeper for shared usage** – the `op` CLI scripts can co-exist with
   Keeper. You can also mirror selected 1Password items into Keeper so the same
   notation-based workflow is used everywhere.

## Troubleshooting

* **No secrets are exported** – ensure `ksm` is installed and on your `PATH`.
  The profile script will log a warning if it cannot find the CLI.
* **Notation lookups fail** – verify the notation string with
  `ksm secret notation <value>`. Remember that Keeper enforces record and field
  permissions.
* **Need to override a secret temporarily** – export the environment variable
  manually before sourcing the profile (or within the shell) and the Keeper
  script will respect the existing value.
