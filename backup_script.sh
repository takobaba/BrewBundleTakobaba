mkdir -p /Users/tarikkaya/.mounty/Seagate\ Expansion\ Drive/L490
mkdir -p /Users/tarikkaya/.mounty/Seagate\ Expansion\ Drive/L490/IPSI
mkdir -p /Users/tarikkaya/.mounty/Seagate\ Expansion\ Drive/L490/Documents
mkdir -p /Users/tarikkaya/.mounty/Seagate\ Expansion\ Drive/L490/Hidden

# Backup Documents
rsync -v -r --exclude "Calibre" --exclude "Max" --exclude "KTM" --exclude "League" --exclude "OCC" --exclude "Super" --exclude "iTerm2" /Users/tarikkaya/Documents/* /Users/tarikkaya/.mounty/Seagate\ Expansion\ Drive/L490/Documents/

# Backup Hidden files
rsync -av --exclude ".rustup" --exclude ".vscode" --exclude ".sdkman" --exclude ".sonar" --exclude ".ocat" --exclude ".pyenv" --exclude ".cargo" --exclude ".gradle" --exclude ".docker" --exclude ".npm" --exclude ".composer" --exclude ".cache" --exclude ".Trash" --exclude ".Trashes" --exclude ".mounty" --exclude ".m2" --exclude ".lemminx" --exclude ".ipython" --exclude ".ansible" --exclude ".3T" --exclude ".android" --exclude ".zcomp" --exclude ".composer" --exclude ".lc" --exclude ".ocat" --exclude ".pretty-clean" --exclude ".redhat" --exclude ".sonar" --exclude ".zsh_sessions" --exclude ".oh-my-zsh" /Users/tarikkaya/.* /Users/tarikkaya/.mounty/Seagate\ Expansion\ Drive/L490/Hidden

# Backup IPSI
rsync -v -r -a --exclude "IPSI-AU" /Users/tarikkaya/IPSI/* /Users/tarikkaya/.mounty/Seagate\ Expansion\ Drive/L490/IPSI/