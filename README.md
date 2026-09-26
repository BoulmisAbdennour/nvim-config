# nvim-config

Ma configuration Neovim pour le C/C++ (HPC : OpenMP, MPI, CMake) et le Python.
Installation en une commande sur Ubuntu ou Fedora.

## Contenu

| Fichier | Rôle |
|---|---|
| `init.vim` | Configuration Neovim : plugins, options, raccourcis |
| `coc-settings.json` | Réglages de clangd (C/C++), avec support de `mpicc` / `mpicxx` |
| `install.sh` | Installe les dépendances, la police, les plugins, et relie la config |

## Installation

```bash
git clone git@github.com:TON_USER/nvim-config.git ~/devTools/nvim
~/devTools/nvim/install.sh
```

Ensuite, dans les préférences du terminal, choisir la police **JetBrainsMono Nerd Font**.

`install.sh` crée un lien `~/.config/nvim → ~/devTools/nvim`. Une config existante n'est pas supprimée : elle est renommée en `~/.config/nvim.backup.*`.

**Prérequis :** Neovim ≥ 0.8 et Node.js ≥ 16.18. Le script vérifie les versions et affiche un avertissement si elles sont trop anciennes.

## Disposition

```
┌──────────┬───────────────────┬──────────────┐
│ NERDTree │       code        │   terminal   │
│ Espace e │                   │     F12      │
└──────────┴───────────────────┴──────────────┘
```

`nvim .` ouvre directement NERDTree à gauche.

## Raccourcis principaux

La touche leader est **Espace**.

| Touches | Action |
|---|---|
| `jk` | Quitter le mode Insertion (comme `Esc`) |
| `Ctrl+h/j/k/l` | Changer de fenêtre (aussi depuis le terminal) |
| `Espace e` | Ouvrir/fermer NERDTree |
| `F12` | Ouvrir/fermer le terminal |
| `Espace ff` / `fg` / `fb` | Chercher un fichier / du texte / un buffer (fzf) |
| `Espace m` | Compiler (CMake → Make → fichier seul) |
| `Espace n` / `Espace p` | Erreur de compilation suivante / précédente |
| `F5` | Compiler et exécuter (C/C++) ou lancer (Python) |
| `gd` / `gr` / `K` | Définition / références / documentation |
| `Espace rn` | Renommer un symbole |
| `Espace ca` | Correction automatique (code action) |
| `Espace h` | Basculer entre `.c`/`.cpp` et `.h` |
| `Espace dl` | Liste des diagnostics |
| `Espace u` / `Espace t` | Historique d'annulation / structure du code |
| `Espace gs` | Statut Git (fugitive) |

## clangd : `compile_commands.json`

Pour que clangd comprenne un projet (includes, flags), il faut ce fichier à la racine :

```bash
# Projet CMake
cmake -S . -B build -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
ln -s build/compile_commands.json .

# Projet Makefile
bear -- make
```

## Plugins

vim-plug · coc.nvim · NERDTree · fzf · vim-floaterm · vim-airline · vim-fugitive · tagbar · undotree · vim-surround · vim-commentary · vim-move · onedark · gruvbox · vim-devicons

## Remerciements

- [freeCodeCamp](https://github.com/freeCodeCamp), pour ses ressources d'apprentissage.
- [NeuralNine](https://github.com/NeuralNine), pour son tutoriel Neovim qui a servi de base à cette configuration.
