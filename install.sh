#!/usr/bin/env bash
# install.sh — environnement Neovim d'Abdennour (Ubuntu / Fedora)
set -euo pipefail
DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

version_ge() { [ "$(printf '%s\n' "$2" "$1" | sort -V | head -1)" = "$2" ]; }

echo "==> 1/5 Paquets"
if command -v apt >/dev/null; then
  sudo apt update
  sudo apt install -y neovim nodejs clangd clang-format ripgrep universal-ctags \
       wl-clipboard xclip bear curl unzip git fontconfig
elif command -v dnf >/dev/null; then
  sudo dnf install -y neovim nodejs clang-tools-extra ripgrep ctags \
       wl-clipboard xclip bear curl unzip git fontconfig
else
  echo "Ni apt ni dnf : distribution non supportée." >&2; exit 1
fi

echo "==> 2/5 Versions"
nvim_v=$(nvim --version | head -1 | grep -oE '[0-9]+\.[0-9]+' | head -1)
node_v=$(node -v | tr -d v)
version_ge "$nvim_v" 0.8   || echo "!! Neovim $nvim_v trop ancien (coc demande >= 0.8)"
version_ge "$node_v" 16.18 || echo "!! Node $node_v trop ancien (coc demande >= 16.18)"

echo "==> 3/5 Police JetBrainsMono Nerd Font"
if ! fc-list | grep "JetBrainsMono Nerd" >/dev/null; then
  tmp=$(mktemp -d)
  curl -fL -o "$tmp/font.zip" \
    https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
  mkdir -p ~/.local/share/fonts/JetBrainsMono
  unzip -oq "$tmp/font.zip" -d ~/.local/share/fonts/JetBrainsMono
  fc-cache -f
  rm -rf "$tmp"
fi

echo "==> 4/5 Lien de la config"
mkdir -p ~/.config
if [ -e ~/.config/nvim ] && [ ! -L ~/.config/nvim ]; then
  mv ~/.config/nvim ~/.config/nvim.backup."$(date +%Y%m%d-%H%M%S)"
  echo "   Ancienne config sauvegardée dans ~/.config/nvim.backup.*"
fi
ln -sfn "$DOTFILES" ~/.config/nvim

echo "==> 5/5 Plugins"
curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim" --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim --headless +'PlugInstall --sync' +qa
nvim --headless +'CocInstall -sync coc-clangd coc-pyright coc-cmake coc-json coc-sh' +qa || true

echo
echo "Terminé. Dernière étape manuelle : police du terminal → JetBrainsMono Nerd Font"
