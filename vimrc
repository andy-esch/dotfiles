" vimrc
" Andy Eschbacher, Jan. 2022

syntax enable
" set background=dark
highlight! link SignColumn LineNr
autocmd ColorScheme * highlight! link SignColumn LineNr
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
" highlight Search ctermfg=white
" highlight Search ctermbg=DarkGrey

" map esc to kj
inoremap kj <ESC>

" vv for new vertical split
nnoremap <silent> vv <C-w>v
" nnoremap <silent> hh <C-w>s

" Black shortened
command B Black


" Remove whitespace in Python files on save
" autocmd BufWritePre * :%s/\s\+$//e

" powerline
python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup

" setup clipboard to work with macos
" TODO: does this fit all the cases you're interested in?
set clipboard=unnamed

" draw a line at column 88
" python black uses 88 by default
set colorcolumn=88
highlight ColorColumn ctermbg=0
" guibg=lightgrey

" backspace rules
set backspace=indent,eol,start

" Vundle pieces
" Install with :PluginInstall
" Update with :PluginUpdate
" More info with :h vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" Package manager
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-sensible'
" 
" Plugin 'tpope/vim-surround'
" Git support
" Plugin 'tpope/vim-fugitive'
" Tmux/vim split navigation/integration
Plugin 'christoomey/vim-tmux-navigator'
" Linter support
Plugin 'dense-analysis/ale'
" Auto complete
Plugin 'davidhalter/jedi-vim'
" Plugin 'Valloric/YouCompleteMe'
Plugin 'micha/vim-colors-solarized'
"Upgrade black version: :BlackUpgrade
Plugin 'psf/black'
Plugin 'fisadev/vim-isort'
Plugin 'mechatroner/rainbow_csv'
" Tab completion within insert mode
Plugin 'ervandew/supertab'
" Plugin 'junegunn/vim-slash'
" Color scheme
Plugin 'itchyny/landscape.vim'
" Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
" show git edits
Plugin 'airblade/vim-gitgutter'
call vundle#end()

colorscheme solarized

" Point YCM to the Pipenv created virtualenv, if possible
" python with virtualenv support

" python3 << EOF
" import os
" import sys
" if 'VIRTUAL_ENV' in os.environ:
"     virtualenv_base_dir = os.environ['VIRTUAL_ENV']
" elif os.path.exists('.venv'):
"     virtualenv_base_dir = os.path.join(os.getcwd(), '.venv')
" 
" 
" activate_this = os.path.join(virtualenv_base_dir, 'bin/activate_this.py')
" exec(open(activate_this, dict(__file__=activate_this))
" EOF

" github.com/dense-analysis/ale (linter)
" Check Python files with flake8 and pylint.
let g:ale_python_ruff_auto_poetry = 1
let g:ale_linters = {'python': ['ruff', 'flake8', 'pylint']} " , 'pylint', 'ruff']}
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'python': ['ruff']
\}
let g:ale_virtualenv_dir_names = ['.venv']
" let g:ale_python_auto_pipenv = 1
" let g:ale_python_flake8_auto_pipenv = 1
" let g:ale_python_pylint_auto_pipenv = 1
let g:ale_python_auto_poetry = 1
let g:ale_python_flake8_auto_poetry = 1
nmap <silent> <C-p> <Plug>(ale_previous_wrap)
nmap <silent> <C-n> <Plug>(ale_next_wrap)

" Vim Markdown config
let g:vim_markdown_folding_disabled = 1
" concel level for vim-markdown, but note
"  this is a global setting
set conceallevel=2

" TODO: setup sensible? https://github.com/tpope/vim-sensible

" highlight OverLength ctermbg=red ctermfg=white guibg=#592929
" match OverLength /\%81v.\+/

" markdown syntax highlighting
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']

" Black(Python) format the visual selection
xnoremap <Leader>k :!black -q -<CR>
