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
# COMPLETION SETTINGS
# ============================================================================
# Enable auto completion features
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# ============================================================================
# KUBECTL COMPLETION
# ============================================================================
# Enable kubectl completion if kubectl is installed
if command -v kubectl &> /dev/null; then
    source <(kubectl completion bash)
    # Also enable completion for 'k' alias
    complete -F __start_kubectl k
fi


# ============================================================================
# COLORS
# ============================================================================
# Enable color support
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# Color variables for prompt
GREEN='\[\033[0;32m\]'
BLUE='\[\033[0;34m\]'
RESET='\[\033[0m\]'

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias diff='diff --color=auto'

# ============================================================================
# GIT PROMPT SETUP
# ============================================================================
# Load git prompt script
source /usr/share/git/git-prompt.sh

# Configure git prompt options
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWCOLORHINTS=1
export GIT_PS1_SHOWUNTRACKEDFILES=1

# ============================================================================
# CUSTOM PROMPT
# ============================================================================
# Format: [user@hostname path] (git-branch) $
PS1="${BLUE}[${GREEN}\u@\h ${BLUE}\w${BLUE}]\$(__git_ps1)${RESET} ${GREEN}\$${RESET} "

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
