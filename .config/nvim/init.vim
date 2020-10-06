call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'nathanaelkane/vim-indent-guides'
Plug 'preservim/nerdcommenter'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-fugitive'
Plug 'vimwiki/vimwiki'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'

call plug#end()

set number

" normalizing tabs to 2 spaces
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

" searching
set incsearch
set ignorecase
set hlsearch
nnoremap <silent> // :noh<enter>

" make
nnoremap <leader>mt :w<enter>:make test<enter>

" commenting
let g:NERDSpaceDelims = 1

nnoremap <leader>ff :Files<enter>
nnoremap <leader>fl :Lines<enter>
nnoremap <leader>fm :Marks<enter>
nnoremap <leader>fc :Commits<enter>

nnoremap <leader>gg :Goyo 120x60
