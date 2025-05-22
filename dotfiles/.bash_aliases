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

# Git Helper Functions - combines git add, git commit and git push in one command
compush() {
    if [ -z "$1" ] || [ $# -gt 1 ]; then
        echo "❌ Error: Please provide exactly one commit message"
        echo "Usage: compush \"your commit message\""
        return 1
    fi
    
    # Check if in a git repository
    if ! git status > /dev/null 2>&1; then
        echo "❌ Error: Not in a git repository"
        return 1
    fi
    
    echo "📁 Staging all changes..."
    if ! git add .; then
        echo "❌ Error: Failed to stage changes"
        return 1
    fi
    
    echo "💾 Committing changes..."
    if ! git commit -m "$1"; then
        echo "❌ Error: Failed to commit changes"
        return 1
    fi
    
    echo "🚀 Pushing to remote..."
    if ! git push; then
        echo "❌ Error: Failed to push changes"
        return 1
    fi
    
    echo "✅ Successfully staged, committed, and pushed changes"
}
