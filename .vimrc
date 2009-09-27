set tabstop=4
set shiftwidth=4
set expandtab               " insert spaces instead of tabs
set showmatch
set incsearch
set ignorecase
set smartcase
set scrolloff=8
set term=linux
set background=dark
syntax on


" Tidy selected lines (or entire file) with _t:
nnoremap <silent> _t :%!perltidy -q<Enter>
vnoremap <silent> _t :!perltidy -q<Enter>
