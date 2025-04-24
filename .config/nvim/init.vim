let mapleader = " "
let maplocalleader = "\\"

function! Nmap(key, func, desc) abort
  execute 'nnoremap ' . a:key . ' ' . a:func
endfunction

" Bootstrap lazy.nvim
let lazypath = stdpath('data') . '/lazy/lazy.nvim'

if !isdirectory(lazypath)
  let lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  let out = system(['git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath])
  if v:shell_error != 0
    echohl ErrorMsg | echom "Failed to clone lazy.nvim:\n" | echohl None
    echohl WarningMsg | echom out | echohl None
    echom "\nPress any key to exit..."
    call getchar()
    qall!
  endif
endif

execute 'set runtimepath^=' . lazypath

" Setup lazy.nvim (this part is Lua only, you need a workaround)
" There's no direct way to replicate require("lazy").setup({...}) in Vimscript.
" You will need to manage plugin loading with a Vimscript plugin manager like vim-plug or dein.vim.
" Example using vim-plug (as a replacement):

" call plug#begin('~/.vim/plugged')
" Plug 'folke/lazy.nvim'
" Plug 'your/other-plugins'
" call plug#end()

" For configuration files, source them manually
source ~/.config/nvim/options.vim
source ~/.config/nvim/keymaps.vim
" source ~/.config/nvim/patch.vim

" Enable inlay hints (requires LSP plugin that supports it)
" NOTE: No direct Vimscript equivalent. This is Lua-only.
" You might need to call this from Lua using:
"   :lua vim.lsp.inlay_hint.enable()

" Diagnostic virtual text
" Lua only — no direct Vimscript equivalent.
" Closest approximation (may require a plugin like ALE for Vim):
"   let g:ale_virtualtext_cursor = 1

set clipboard=unnamedplus
set number
set relativenumber
set shiftwidth=2
set tabstop=2
set softtabstop=2
set nowrap
set colorcolumn=80
set scrolloff=5
set termguicolors

autocmd BufReadPost,FileReadPost * normal! zR

let mapleader = " "

set list
set listchars=tab:·\ ,trail:·,extends:»,precedes:«,nbsp:░

autocmd BufRead,BufNewFile */.config/i3/config.d/* if &filetype !=# 'oil' | set filetype=i3config | endif
