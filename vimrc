" vimrc
" Andy Eschbacher, Feb. 2020

syntax enable
set background=light
set nocompatible
filetype off
set laststatus=2
" show line number
set number
" show curson position
set ruler
filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
" highlight all search matches (from "/pattern")
set hlsearch
hi Search ctermfg=white
hi Search ctermbg=blue

" map esc to kj
inoremap kj <ESC>

" vv for new vertical split
nnoremap <silent> vv <C-w>v
" nnoremap <silent> hh <C-w>s

" powerline
python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup

" setup clipboard to work with macos
" TODO: does this fit all the cases you're interested in?
set clipboard=unnamed

" draw a line at column 88
set colorcolumn=88
highlight ColorColumn ctermbg=0 guibg=lightgrey

" backspace rules
set backspace=indent,eol,start

" Vundle pieces
" Install with :PluginInstall
" Update with :PluginUpdate
" More info with :h vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-markdown'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'w0rp/ale'
Plugin 'davidhalter/jedi-vim'
Plugin 'micha/vim-colors-solarized'
Plugin 'psf/black'
Plugin 'mechatroner/rainbow_csv'
Plugin 'ervandew/supertab'
call vundle#end()

" Add fzf to runtime path
set rtp+=/usr/local/opt/fzf
" setup pathogen (github.com/tpope/vim-pathogen)
"execute pathogen#infect()

" github.com/w0rp/ale (linter)
" set statusline+=%{ALEGetStatusLine()}
" let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
nmap <silent> <C-p> <Plug>(ale_previous_wrap)
nmap <silent> <C-n> <Plug>(ale_next_wrap)

" Vim Jedi configuration
let g:jedi#use_tabs_not_buffers = 1
let g:jedi#use_splits_not_buffers = "left"

" TODO: setup sensible? https://github.com/tpope/vim-sensible

" highlight OverLength ctermbg=red ctermfg=white guibg=#592929
" match OverLength /\%81v.\+/

" markdown syntax highlighting
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']

