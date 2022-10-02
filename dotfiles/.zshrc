[ -n "$GCTL_SESSION_ID" ] || [ -n "$TERM_SESSION_ID" ] || export GCTL_SESSION_ID=$(uuidgen)

source ~/.p10k.zsh
source ~/.zsh_additions

#fzf
if [ -n "${commands[fzf-share]}" ]; then
  source "$(fzf-share)/key-bindings.zsh"
  source "$(fzf-share)/completion.zsh"
fi

# additional envs
borgUser=borg
borgServer=192.168.55.200
borgBackupPath=/backups/manjaro
borg=ssh://$borgUser@$borgServer$borgBackupPath