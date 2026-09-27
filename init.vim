" ~/.config/nvim/init.vim — Abdennour | Neovim, C/C++/HPC/Python
let mapleader = " "

" ================= Bootstrap vim-plug =================
let s:plug = stdpath('data') . '/site/autoload/plug.vim'
if empty(glob(s:plug))
  execute '!curl -fLo ' . shellescape(s:plug) . ' --create-dirs '
        \ . 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  execute 'source ' . fnameescape(s:plug)
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" ================= Plugins =================
call plug#begin()
" Édition
Plug 'tpope/vim-surround'                          " ysiw)  cs"'  ds(
Plug 'tpope/vim-commentary'                        " gcc  gc{motion}
Plug 'matze/vim-move'                              " Alt-j / Alt-k déplace lignes/sélection
Plug 'alvan/vim-closetag'
" Navigation
Plug 'preservim/nerdtree'
Plug 'preservim/tagbar', {'on': 'TagbarToggle'}    " nécessite universal-ctags
Plug 'junegunn/fzf', {'do': { -> fzf#install() }}
Plug 'junegunn/fzf.vim'                            " :Rg nécessite ripgrep
Plug 'mbbill/undotree'
" Git / terminal
Plug 'tpope/vim-fugitive'
Plug 'voldikss/vim-floaterm'
" LSP / complétion
Plug 'neoclide/coc.nvim', {'branch': 'release'}    " nécessite nodejs
" Langages
Plug 'vim-python/python-syntax'
Plug 'lepture/vim-jinja'
" Apparence (devicons EN DERNIER)
Plug 'navarasu/onedark.nvim'
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
call plug#end()

" ================= Général =================
set number relativenumber
set mouse=a
set cursorline
set scrolloff=8 sidescrolloff=5
set nowrap
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab shiftround
set ignorecase smartcase
set splitbelow splitright
set hidden
set undofile
set clipboard=unnamedplus
set signcolumn=yes
set updatetime=300
set shortmess+=c
set termguicolors
set list listchars=tab:»\ ,trail:·,nbsp:␣
set wildignore+=*.o,*.a,*.so,*/build/*,*/.git/*
set path=.,,include/**,src/**
set tags=./tags;
set visualbell

" Nombre de cœurs pour make -j (plafonné à 8)
let s:jobs = max([1, min([str2nr(trim(system('nproc'))), 8])])

" ================= Thème =================
try
  colorscheme onedark
  let g:airline_theme = 'onedark'
  " colorscheme gruvbox | let g:airline_theme = 'gruvbox'
catch
  colorscheme habamax
endtry

" ================= Airline =================
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

" ================= NERDTree (gauche) =================
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '~'
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeChDirMode = 2                  " C dans NERDTree = change le dossier de nvim
let g:NERDTreeIgnore = ['\.o$', '\.a$', '\.so$', '^build$', '^\.git$']

" ================= Terminal (droite) =================
let g:floaterm_wintype  = 'vsplit'
let g:floaterm_position = 'botright'
let g:floaterm_width    = 0.4
let g:floaterm_keymap_new    = '<F7>'
let g:floaterm_keymap_prev   = '<F8>'
let g:floaterm_keymap_next   = '<F9>'
let g:floaterm_keymap_toggle = '<F12>'

" ================= fzf =================
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --glob "!.git" --glob "!build"'
let g:fzf_layout = {'window': {'width': 0.9, 'height': 0.8}}

" ================= Divers plugins =================
let g:python_highlight_all = 1
let g:closetag_filenames = '*.html,*.xhtml,*.jinja,*.j2'
let g:coc_disable_startup_warning = 1
let g:coc_global_extensions = ['coc-clangd', 'coc-pyright', 'coc-cmake',
      \ 'coc-json', 'coc-sh']

" ================= Mappings généraux =================
inoremap jk <Esc>
nnoremap Y y$
vnoremap < <gv
vnoremap > >gv
nnoremap <F3> :nohlsearch<CR>
nnoremap <silent> <leader><space> :nohlsearch<CR>

" Mode apprentissage : supprime ces 4 lignes quand hjkl est un réflexe
nnoremap <Up>    <Nop>
nnoremap <Down>  <Nop>
nnoremap <Left>  <Nop>
nnoremap <Right> <Nop>

" Fenêtres : Ctrl+hjkl depuis le code ET depuis le terminal
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l

" Clic milieu désactivé
for s:m in ['', '2-', '3-', '4-']
  execute 'map  <' . s:m . 'MiddleMouse> <Nop>'
  execute 'imap <' . s:m . 'MiddleMouse> <Nop>'
endfor

nnoremap <leader>w  :w<CR>
nnoremap <leader>q  :q<CR>
nnoremap <leader>v  :edit $MYVIMRC<CR>
nnoremap <leader>s  :source $MYVIMRC<CR>

" Fichiers / recherche
nnoremap <leader>e  :NERDTreeToggle<CR>
nnoremap <leader>E  :NERDTreeFind<CR>
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fg :Rg<CR>
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>fl :BLines<CR>
nnoremap <leader>u  :UndotreeToggle<CR>
nnoremap <leader>t  :TagbarToggle<CR>
nnoremap <F6>       :TagbarToggle<CR>

" Git
nnoremap <leader>gs :Git<CR>
nnoremap <leader>gb :Git blame<CR>
nnoremap <leader>gd :Gdiffsplit<CR>

" Compilation / exécution
nnoremap <silent> <leader>m :call <SID>Build()<CR>
nnoremap <silent> <F5>      :call <SID>Run()<CR>
nnoremap <leader>n  :cnext<CR>
nnoremap <leader>p  :cprevious<CR>

" ================= coc.nvim =================
function! s:CheckBackspace() abort
  let l:col = col('.') - 1
  return !l:col || getline('.')[l:col - 1] =~# '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ <SID>CheckBackspace() ? "\<Tab>" : coc#refresh()
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
      \ : "\<C-g>u\<CR>\<C-r>=coc#on_enter()\<CR>"
inoremap <silent><expr> <C-space> coc#refresh()

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> <leader>dp <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>dn <Plug>(coc-diagnostic-next)
nnoremap <silent> <leader>dl :CocList diagnostics<CR>
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>ca <Plug>(coc-codeaction-cursor)
nmap <leader>cf <Plug>(coc-format)
xmap <leader>cf <Plug>(coc-format-selected)
nnoremap <silent> <leader>h :CocCommand clangd.switchSourceHeader<CR>
nnoremap <silent> K :call <SID>ShowDoc()<CR>

function! s:ShowDoc() abort
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" ================= Fonctions =================
" CMake si build/ existe, sinon Makefile, sinon compile le fichier seul
function! s:Build() abort
  wall
  let l:j = ' -j' . s:jobs
  if filereadable('CMakeLists.txt') && isdirectory('build')
    let &l:makeprg = 'cmake --build build' . l:j
  elseif filereadable('Makefile') || filereadable('makefile')
    let &l:makeprg = 'make' . l:j
  else
    let &l:makeprg = 'make CFLAGS="-Wall -Wextra -g -O2 -fopenmp" '
          \ . 'CXXFLAGS="-Wall -Wextra -g -O2 -std=c++17 -fopenmp" '
          \ . shellescape(expand('%:r'))
  endif
  silent make!
  redraw!
endfunction

" F5 : Python → terminal ; C/C++ → compile, puis exécute si le binaire est à jour
function! s:Run() abort
  write
  if &filetype ==# 'python'
    execute 'FloatermNew --autoclose=0 python3 ' . shellescape(expand('%'))
  elseif &filetype =~# '^c\(pp\)\=$'
    call s:Build()
    let l:exe = expand('%:r')
    if filereadable(l:exe) && getftime(l:exe) >= getftime(expand('%'))
      execute 'FloatermNew --autoclose=0 ./' . shellescape(l:exe)
    endif
  endif
endfunction

function! s:StripTrailing() abort
  let l:view = winsaveview()
  keeppatterns %s/\s\+$//e
  call winrestview(l:view)
endfunction

" ================= Autocommandes =================
augroup abdennour
  autocmd!
  " nvim . → NERDTree à gauche + zone de code vide au centre
  autocmd StdinReadPre * let s:std_in = 1
  autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in')
        \ | execute 'cd ' . fnameescape(argv()[0])
        \ | execute 'NERDTree'
        \ | wincmd p | enew | endif
  " Rouvrir un fichier à la dernière position du curseur
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit'
        \ | exe "normal! g`\"" | endif
  " Langages
  autocmd FileType c,cpp,cuda setlocal colorcolumn=100 foldmethod=indent foldlevel=99
        \ commentstring=//\ %s
  autocmd FileType make setlocal noexpandtab tabstop=8 shiftwidth=8 softtabstop=0
  autocmd FileType markdown,tex,text setlocal wrap linebreak spell spelllang=fr,en
  autocmd FileType gitcommit setlocal spell spelllang=en textwidth=72
  autocmd BufWritePre *.c,*.h,*.cpp,*.hpp,*.cu,*.py,CMakeLists.txt call s:StripTrailing()
  " Compilation : ouvrir la liste d'erreurs s'il y en a
  autocmd QuickFixCmdPost [^l]* cwindow
  " coc : surligner le symbole sous le curseur
  autocmd CursorHold * silent call CocActionAsync('highlight')
  " Terminal : sans numéros, directement en mode saisie
  autocmd TermOpen * setlocal nonumber norelativenumber signcolumn=no
  autocmd BufEnter term://* startinsert
  " Fermer nvim si NERDTree est la dernière fenêtre
  autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree()
        \ | call feedkeys(":quit\<CR>:\<BS>") | endif
augroup END
" NERDTree : rafraîchir l'arbre à chaque fois qu'on y entre
augroup nerdtree_refresh
  autocmd!
  autocmd BufEnter NERD_tree_* silent! NERDTreeRefreshRoot
augroup END
