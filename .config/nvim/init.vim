
call plug#begin()
Plug 'neovim/nvim-lspconfig'
Plug 'morhetz/gruvbox'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
call plug#end()

if has('termguicolors')
  set termguicolors
endif

set background=dark
colorscheme gruvbox

let mapleader = " "
syntax on
set tabstop=2
set timeoutlen=300
set shiftwidth=2
set noshowmode
set noerrorbells
set guicursor=
set expandtab
set scrolloff=3
set nowrap
set ai
set nu
set hlsearch
set ruler
set updatetime=50
set signcolumn=yes
set relativenumber
set shortmess+=c
set showcmd
set cmdheight=2
set completeopt=menuone,noinsert,noselect

lua require('lspconfig').tsserver.setup{on_attach=require'completion'.on_attach}
