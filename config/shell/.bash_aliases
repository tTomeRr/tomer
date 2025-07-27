# Editor Aliases
alias vim='nvim'

# SSH and Remote Access
alias connect-with-ssh='ssh user@ip -t "cd /path/to/folder && exec bash --login"'
alias connect-with-gcp='gcloud compute ssh $VM_NAME --project=$PROJECT --zone=$ZONE --tunnel-through-iap'

# Navigation and Project Shortcuts
alias project_name='cd $HOME/Projects/project_name'

# Pre-made Tabs Launcher
alias tfirefox='bash $HOME/Scripts/.firefox_tabs.sh &'

# Container and Orchestration
alias dokcer='docker'  # Typo fix
alias k='kubectl'

# System & File Operations
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# Git Helper Functions - combines git add, git commit and git push in one command
compush() {
    [ -z "$1" ] && { echo "Usage: compush \"message\""; return 1; }
    git add . && git commit -m "$1" && git push && echo "✅ Done"
}
