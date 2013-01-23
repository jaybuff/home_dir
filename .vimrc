set tabstop=2
set shiftwidth=2
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

highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

" remove trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e

" for evervim (evernote plugin)

let $PYTHONPATH='/Users/jaybuff/.vim/plugin/py'
let g:evervim_devtoken='S=s103:U=1228bda:E=142968175cf:C=13b3ed049cf:P=1cd:A=en-devtoken:H=06235083e1ccc3d3de8cb584ed11a11f'

