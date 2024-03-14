alias g="git"
autoload -Uz compinit && compinit

alias tf="terraform"
complete -F _minimal tf

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
