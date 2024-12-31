alias g="git"
autoload -Uz compinit && compinit
autoload -U +X bashcompinit && bashcompinit

alias tf="terraform"
complete -F _minimal tf
if [[ $(whoami) == "vscode" ]]; then
    # if running in vscode devcontainers
    complete -o nospace -C /usr/local/bin/terraform terraform
else
    complete -o nospace -C /opt/homebrew/bin/terraform terraform
fi

alias sz="source ~/.zshrc"
alias update="brew update && brew upgrade && brew cleanup && brew doctor"


# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats '%b'

# Show branch name if and only if it exists
branch_name() {
    [ -z "$vcs_info_msg_0_" ] || echo "[$vcs_info_msg_0_]"
}

# Get PR number with gh
gh_pr() {
    number=$(gh pr status --json number --jq ".currentBranch.number" 2> /dev/null)
    [ -z "$number" ] || echo "#$number"
}

# Set up the prompt
setopt PROMPT_SUBST
PROMPT='%F{blue}[%n@ %1~]%F{green}$(branch_name)%F{white}%F{yellow}$(gh_pr)%F{white}$ '

# Check if GitHub CLI Copilot extension is installed
if gh extension list | grep -q 'copilot'; then
    # Add GitHub CLI copilot alias
    eval "$(gh copilot alias -- zsh)"
fi
