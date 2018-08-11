set nocompatible

call plug#begin('~/.vim/plugged')

Plug 'ervandew/supertab'
Plug 'ntpeters/vim-better-whitespace'
Plug 'autozimu/LanguageClient-neovim', {
      \ 'branch': 'next',
      \ 'do': 'bash install.sh',
      \ }
Plug 'jiangmiao/auto-pairs'
Plug 'jlanzarotta/bufexplorer'
Plug 'tpope/vim-surround'
Plug 'w0rp/ale'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'dyng/ctrlsf.vim'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'editorconfig/editorconfig-vim'
Plug 'moll/vim-node'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'tpope/vim-rails', { 'for': 'ruby' }
Plug 'tpope/vim-bundler', { 'for': 'ruby' }
Plug 'tpope/vim-endwise'
Plug 'michaeljsmith/vim-indent-object'
Plug 'ekalinin/Dockerfile.vim'

Plug 'posva/vim-vue'
Plug 'kchmck/vim-coffee-script'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'AndrewRadev/splitjoin.vim'

call plug#end()

let mapleader = "\<Space>"

language en_US
" https://github.com/vim/vim/blob/master/runtime/doc/russian.txt
" Enable hotkeys for Russian layout
set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz

set hidden
set number

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowritebackup
set nowb
set noswapfile

set expandtab
set softtabstop=2
set shiftwidth=2

" colorscheme solarized

" Map ctrl-movement keys to window switching
map <C-k> <C-w><Up>
map <C-j> <C-w><Down>
map <C-l> <C-w><Right>
map <C-h> <C-w><Left>

" Edit .vimrc
map <leader>vl :vsp $MYVIMRC<CR>
map <leader>vr :source $MYVIMRC<CR>

""" Plugins Keymaps

nmap <C-m> :NERDTreeFind<CR>
nmap <silent> <leader><leader> :NERDTreeToggle<CR>

nnoremap <leader>b :BufExplorer<CR>

" Move between linting errors
nnoremap ]r :ALENextWrap<CR>
nnoremap [r :ALEPreviousWrap<CR>

""" Plugin Settings

let g:LanguageClient_serverCommands = {
      \ 'ruby': [ 'solargraph', 'stdio' ]
      \ }

let g:ale_php_phpcs_standard = 'PSR2'

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

nnoremap <Leader>o :GFiles .<CR>
nnoremap <leader>ff :Files<CR>
nnoremap <Leader>w :wa<CR>

nmap <silent> // :nohlsearch<CR>
noremap ,hl :set hlsearch! hlsearch?<CR>

let g:airline#extensions#ale#enabled = 1

nmap <C-F>f <Plug>CtrlSFPrompt
vmap <C-F>f <Plug>CtrlSFVwordPath
nmap <C-F>n <Plug>CtrlSFCwordPath
nnoremap <C-F>t :CtrlSFToggle<CR>
inoremap <C-F>t <Esc>:CtrlSFToggle<CR>

augroup common
  autocmd BufEnter * EnableStripWhitespaceOnSave
augroup END

augroup filetypedetect
  autocmd BufEnter *.php setlocal ts=4 sw=4 sts=4
augroup END

" Move lines up and down
nnoremap Ô :m .+1<CR>==
nnoremap  :m .-2<CR>==
inoremap Ô <Esc>:m .+1<CR>==gi
inoremap  <Esc>:m .-2<CR>==gi
vnoremap Ô :m '>+1<CR>gv=gv
vnoremap  :m '<-2<CR>gv=gv

let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'

autocmd FileType vue syntax sync fromstart

autocmd FileType ruby setlocal omnifunc=LanguageClient#complete
let g:deoplete#enable_at_startup = 1

let g:splitjoin_ruby_curly_braces = 0
let g:splitjoin_ruby_hanging_args = 0
let g:rails_projections = {
      \  "app/controllers/*_controller.rb": {
      \      "test": [
      \        "spec/requests/{}_spec.rb",
      \        "spec/controllers/{}_controller_spec.rb",
      \        "test/controllers/{}_controller_test.rb"
      \      ],
      \      "alternate": [
      \        "spec/requests/{}_spec.rb",
      \        "spec/controllers/{}_controller_spec.rb",
      \        "test/controllers/{}_controller_test.rb"
      \      ],
      \   },
      \   "spec/requests/*_spec.rb": {
      \      "command": "request",
      \      "alternate": "app/controllers/{}_controller.rb",
      \      "template": "require 'rails_helper'\n\n" .
      \        "RSpec.describe '{}' do\nend",
      \   },
      \ }

let g:ale_fixers = {
      \   'ruby': ['rubocop']
      \ }
