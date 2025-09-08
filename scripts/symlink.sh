#!/bin/sh

# Up from scripts dir
cd ..

dotfilesDir=$(pwd)

# Generic linker: source path -> destination path (creates parent dir, backs up existing)
link_file() {
  src="$1"
  dest="$2"
  dateStr=$(date +%Y-%m-%d-%H%M)

  # Ensure destination directory exists
  destDir=$(dirname "$dest")
  [ -d "$destDir" ] || mkdir -p "$destDir"

  if [ -h "$dest" ]; then
    # Existing symlink
    echo "Removing existing symlink: $dest"
    rm -f "$dest"
  elif [ -f "$dest" ]; then
    # Existing file
    echo "Backing up existing file: $dest"
    mv "$dest" "${dest}.${dateStr}"
  elif [ -d "$dest" ]; then
    # Existing dir
    echo "Backing up existing dir: $dest"
    mv "$dest" "${dest}.${dateStr}"
  fi

  echo "Creating new symlink: $dest -> $src"
  ln -s "$src" "$dest"
}

# Back-compat helper: link dotfiles stored at repo root to $HOME
linkDotfile() {
  relPath="$1"
  link_file "${dotfilesDir}/${relPath}" "${HOME}/${relPath}"
}

# Home dotfiles
linkDotfile .bashrc
linkDotfile .gitconfig
linkDotfile .gitignore

# VS Code config
link_file "${dotfilesDir}/vscode/keybindings.json" "${HOME}/.config/Code/User/keybindings.json"
link_file "${dotfilesDir}/vscode/settings.json" "${HOME}/.config/Code/User/settings.json"