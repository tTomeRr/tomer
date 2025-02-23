# Editor Aliases
alias vim='nvim'

# SSH and Remote Access
alias machine_name='user@ip "cd /path/to/folder && bash --login"' # To be used with SSH
alias connect-to-gcp='gcloud compute ssh $VM_NAME --project=$PROJECT --zone=$ZONE --tunnel-through-iap'

# Navigation and Project Shortcuts
alias project_name='cd $HOME/Projects/project_name'

# Tabs Launcher
alias tfirefox='bash /home/tomer/Scripts/.firefox_tabs.sh &'

# Container and Orchestration
alias dokcer='docker'  # Typo fix
alias k='kubectl'

# Git Helper Functions - combines git add, git commit and git push in one command
compush() {
    if [ -z "$1" ] || [ $# -gt 1 ]; then
        echo "Error: Please provide a commit message"
        echo "Usage: compush \"your commit message\""
        return 1
    fi
    
    if ! git add .; then
        echo "Error: git add failed"
        return 1
    fi
    
    if ! git commit -m "$1"; then
        echo "Error: git commit failed"
        return 1
    fi
    
    if ! git push; then
        echo "Error: git push failed"
        return 1
    fi
    
    echo "✅ Successfully added, committed, and pushed changes"
}
