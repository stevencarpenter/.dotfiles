# ----------------------------------------------------------------------
# Zsh Profile Configuration:
# ----------------------------------------------------------------------
# Executed once for each login shell before the shell session starts.
# It's used for setting up environment variables and running commands
# that should be executed at login.
# ----------------------------------------------------------------------

# The following have to go in .zprofile, because they are used by
# macOS's /etc/zshrc file, which is sourced _before_ your`.zshrc`
# file.
export SHELL_SESSION_DIR=$XDG_STATE_HOME/zsh/sessions
export SHELL_SESSION_FILE=$SHELL_SESSION_DIR/$TERM_SESSION_ID

# Cloudflare Secrets Lumin
export CLOUDFLARE_API_KEY="SMUDGED_CLOUDFLARE_API_KEY"
export CLOUDFLARE_EMAIL="SMUDGED_CLOUDFLARE_EMAIL"

export NPM_TOKEN="SMUDGED_NPM_TOKEN"

## my zsh functions

# Get assumed role credentials for AWS
# eg: get_assumed_role_credentials arn:aws:iam::666666666666:role/my-dope-role my-session-name
function get_assumed_role_credentials {
    if [ $# -lt 2 ]; then
        echo "Usage: $get_assumed_role_credentials[1] <arn> <session-name>"
        echo "You must already have credentials in your environment for the account you are assuming a role in."
        echo "Use aws-sso-profile, or asp if you are using my aliases, and select the role for the account via the autocompletion mechanism."
        return
    fi

    export $(printf "AWS_ACCESS_KEY_ID=%s AWS_SECRET_ACCESS_KEY=%s AWS_SESSION_TOKEN=%s" \
    $(aws sts assume-role \
    --role-arn $1 \
    --role-session-name $2 \
    --query "Credentials.[AccessKeyId,SecretAccessKey,SessionToken]" \
    --output text))
}

function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

profile_dir="${ZDOTDIR}/profile.d"
if [[ -d "$profile_dir" && -n "$(ls -A $profile_dir)" ]]; then
    for file in $profile_dir/*; do
        source "$file"
    done
fi

eval "$(/opt/homebrew/bin/brew shellenv)"
