#!/bin/bash

backup_dir="$HOME/backup"
source_dirs=("$HOME/AnkiCards" "$HOME/Scripts" "$HOME/Vault" "$HOME/Apps" "$HOME/Prompts")
num_of_backups_to_keep=7

log() {
    echo "$(date '+%Y-%m-%d %H_%M_%S') - $1" >> "$backup_dir/backup.log"
}

create_folder_if_not_exists() {
    local dir="$1"
    if [[ ! -d "$dir" ]]; then
        mkdir -p "$dir"
    fi
}

create_backup() {
    local full_dir="$1"

    local dir_name
    dir_name=$(basename "$full_dir")

    local backup_file
    backup_file="$backup_dir/$dir_name/$(date '+%Y-%m-%d_%H_%M_%S')"
    
    if rsync -av --exclude='*.log' "$full_dir/" "$backup_file/"; then
        if tar -czf "$backup_file.tar.gz" -C "$(dirname "$backup_file")" "$(basename "$backup_file")"; then
            rm -rf "$backup_file"
            log "Successfully backed up $full_dir to $backup_file.tar.gz"
        else
            log "Failed to create tarball for $backup_file"
            return 1
        fi
    else
        log "Failed to rsync $full_dir to $backup_file"
        return 1
    fi
}

delete_backups() {
    local dir="$1"
    local num_of_files
    num_of_files=$(find "$dir" -maxdepth 1 -type f -name "*.tar.gz" | wc -l)
    
    if (( num_of_files > num_of_backups_to_keep )); then
        find "$dir" -maxdepth 1 -type f -name "*.tar.gz" -printf "%T@ %p\n" | 
            sort -n | 
            head -n "$(( num_of_files - num_of_backups_to_keep ))" | 
            cut -d' ' -f2- | 
            xargs rm -f
        log "Deleted old backups in $dir"
    fi
}

main() {
    create_folder_if_not_exists "$backup_dir"

    for full_dir in "${source_dirs[@]}"; do
        if [[ ! -d "$full_dir" ]]; then
            log "Warning: Directory $full_dir does not exist. Skipping backup."
            continue
        fi

        dir_name=$(basename "$full_dir")
        current_backup_dir="$backup_dir/$dir_name"
        create_folder_if_not_exists "$current_backup_dir"
        if create_backup "$full_dir"; then
            delete_backups "$current_backup_dir"
        else
            log "Skipping cleanup for $full_dir due to backup failure"
        fi
    done
}

main
