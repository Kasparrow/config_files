"editor properties
set nocompatible
syntax on
set number
set showmatch
set visualbell
set ruler
set undolevels=100
set backspace=indent,eol,start
set mouse=

" indent
filetype plugin on
filetype indent on
set expandtab
autocmd Filetype html setlocal tabstop=2 shiftwidth=2 softtabstop=0
autocmd Filetype css  setlocal ts=2 sw=2 sts=0
autocmd Filetype javascript   setlocal ts=2 sw=2 sts=0
autocmd Filetype c    setlocal ts=4 sw=4 sts=0
autocmd Filetype cpp  setlocal ts=4 sw=4 sts=0

" PLUG
call plug#begin('~/.config/nvim')
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'rking/ag.vim'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'dense-analysis/ale'
Plug 'vim-airline/vim-airline'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'Yggdroot/indentLine'
Plug 'rust-lang/rust.vim'
Plug 'airblade/vim-localorie'
Plug 'slim-template/vim-slim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ggandor/leap.nvim'
Plug 'tpope/vim-repeat'
call plug#end()

lua require('leap').add_default_mappings()
" colorscheme nord
set t_Co=256   " This is may or may not needed.

let g:airline_theme = "palenight"
colorscheme palenight

let g:ale_sign_column_always = 1
let g:ale_lint_on_text_changed = "never"

" Only run linters from ale_linters
let g:ale_linters_explicit = 1

" Linters: show warnings and errors
let g:ale_linters = {
                        \ 'ruby': ['rubocop'],
                        \ 'javascript': ['eslint'],
                        \ 'typescript': ['eslint'],
                        \ 'elm': ['elm_ls']
                        \}

" Fixers: fix/format code automatically
let g:ale_fixers = {
                        \  'ruby': ['prettier'],
                        \  'javascript': ['prettier'],
                        \  'elm': ['elm-format'],
                        \  'typescript': ['prettier']
                        \}

let g:coc_global_extensions = [
                        \ 'coc-tsserver'
                        \ ]

" Run fixers at save time only
let g:ale_fix_on_save = 1

" Fugitive Conflict Resolution
let mapleader=","
nnoremap <leader>gd :Gvdiff!<CR>
nnoremap gdl :diffget //2<CR>
nnoremap gdr :diffget //3<CR>

" Custom binding
map <silent> <C-n> :NERDTreeToggle<CR>
nnoremap <leader>n :NERDTreeFind<CR>
nnoremap <leader>fa :GFiles<CR>
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>fw :Ag <c-r>=expand("<cword>")<cr><CR>
nnoremap <leader>fi :Ag -G '\.yml' <c-r>=expand("<cword>")<cr><CR>
nnoremap <leader>ft :Ag -G '_test\.rb' <c-r>=expand("<cword>")<cr><CR>
nnoremap <leader>; <ESC>:vertical resize +10<CR>
nnoremap <leader>j <ESC>:vertical resize -10<CR>
nnoremap <leader>r <ESC>:so ~/.config/nvim/init.vim<CR>
nnoremap <leader>tt <ESC>:call SplitTermAndRunTest()<CR>
nnoremap <leader>tc <ESC>:call SplitTermAndRunCbTest()<CR>
nnoremap <silent><expr> <leader>s (&hls && v:hlsearch ? ':nohls' : ':set hls')."\n"

" status bar
set laststatus=2

" exit insert mode
inoremap jk <esc>
inoremap kj <esc>

let g:indentLine_leadingSpaceChar='·'
let g:indentLine_leadingSpaceEnabled='1'
set hlsearch

" localorie
autocmd CursorMoved *.yml echo localorie#expand_key()

function! CopyFileAndLine()
        let @+ = 'rt '.expand('%:p').':'.line('.')
endfunction

function! SplitTermAndRunTest()
        let test_cmd = 'rails t '.expand('%:p').':'.line('.')
        :call system('tmux split-window -v -p 35')
        :call system("tmux send-keys '".test_cmd."' C-m")
endfunction

function! SplitTermAndRunCbTest()
        let test_cmd = 'COUCHBASE_TEST=1 rails t '.expand('%:p').':'.line('.')
        :call system('tmux split-window -v -p 35')
        :call system("tmux send-keys '".test_cmd."' C-m")
endfunction

inoremap <silent> <F1> <Esc>:call CopyFileAndLine()<CR>
