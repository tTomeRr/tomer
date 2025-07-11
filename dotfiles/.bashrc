# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# ============================================================================
# HISTORY CONFIGURATION
# ============================================================================
HISTSIZE=5000
HISTFILESIZE=10000
HISTCONTROL=ignoreboth:erasedups  # Ignore duplicates and lines starting with space

# Share history between sessions
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# ============================================================================
# KUBECTL COMPLETION
# ============================================================================
# Enable kubectl completion
if command -v kubectl &> /dev/null; then
    source <(kubectl completion bash)
    # Also enable completion for 'k' alias
    complete -F __start_kubectl k
fi

# ============================================================================
# COMPLETION SETTINGS
# ============================================================================
# Enable completion features
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Load git completion
if [ -f /usr/share/git/completion/git-completion.bash ]; then
    source /usr/share/git/completion/git-completion.bash
elif [ -f /usr/share/bash-completion/completions/git ]; then
    source /usr/share/bash-completion/completions/git
fi

# ============================================================================
# COLORS
# ============================================================================
# Enable color support
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# Color variables for prompt
RED='\[\033[0;31m\]'
GREEN='\[\033[0;32m\]'
BLUE='\[\033[0;34m\]'
CYAN='\[\033[0;36m\]'
YELLOW='\[\033[1;33m\]'
PURPLE='\[\033[0;35m\]'
WHITE='\[\033[1;37m\]'
RESET='\[\033[0m\]'

# ============================================================================
# GIT PROMPT FUNCTION
# ============================================================================
git_branch() {
    local branch
    if branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null); then
        if [[ $branch == "HEAD" ]]; then
            branch='detached*'
        fi
        
        # Check if repo has changes (including untracked files)
        if git diff-index --quiet HEAD -- 2>/dev/null && [ -z "$(git ls-files --others --exclude-standard 2>/dev/null)" ]; then
            # Clean repo - green
            echo -e " \033[32m(${branch})\033[0m"
        else
            # Dirty repo - red
            echo -e " \033[31m(${branch})\033[0m"
        fi
    fi
}

# ============================================================================
# CUSTOM PROMPT
# ============================================================================
# Format: [user@hostname path] (git-branch) $
PS1="${BLUE}[${GREEN}\u@\h ${BLUE}\w${BLUE}]\$(git_branch)${RESET} ${GREEN}\$${RESET} "

# ============================================================================
# ENVIRONMENT VARIABLES
# ============================================================================
# Default editor
export EDITOR=nvim
export VISUAL=nvim

# ============================================================================
# LOAD ALIASES
# ============================================================================
# Load custom aliases if they exist
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
