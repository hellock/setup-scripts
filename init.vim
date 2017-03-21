set nocompatible
filetype off
syntax on
set encoding=utf-8
set number
set expandtab
set shiftwidth=4
set tabstop=4
set autoindent
set ruler
set hlsearch
set mouse-=a

set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin('~/.config/nvim/bundle')
	Plugin 'VundleVim/Vundle.vim'
	Plugin 'vim-airline/vim-airline'
	Plugin 'vim-airline/vim-airline-themes'
	Plugin 'Valloric/YouCompleteMe'
    Plugin 'scrooloose/nerdcommenter'
    Plugin 'nvie/vim-flake8'
call vundle#end()
filetype plugin indent on

let g:ycm_always_populate_location_list = 1
nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>

let g:airline_powerline_fonts = 1

" add a space when commenting
let g:NERDSpaceDelims=1

set laststatus=2