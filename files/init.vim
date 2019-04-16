call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'jlanzarotta/bufexplorer'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'nanotech/jellybeans.vim'
Plug 'dyng/ctrlsf.vim'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'editorconfig/editorconfig-vim'
Plug 'moll/vim-node'
Plug 'tpope/vim-rails', { 'for': 'ruby' }
Plug 'tpope/vim-bundler', { 'for': 'ruby' }
Plug 'tpope/vim-endwise'
Plug 'michaeljsmith/vim-indent-object'
Plug 'ekalinin/Dockerfile.vim'

Plug 'jiangmiao/auto-pairs'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'rizzatti/dash.vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

call plug#end()

set nocompatible

let mapleader = "\<Space>"

language en_US
" https://github.com/vim/vim/blob/master/runtime/doc/russian.txt
" Enable hotkeys for Russian layout
set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz

set cursorline
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

set cmdheight=2
set signcolumn=yes

colorscheme jellybeans

" Map ctrl-movement keys to window switching
map <C-k> <C-w><Up>
map <C-j> <C-w><Down>
map <C-l> <C-w><Right>
map <C-h> <C-w><Left>

" Edit .vimrc
map <leader>vl :vsp $MYVIMRC<CR>
map <leader>vr :source $MYVIMRC<CR>

""" Plugins Keymaps

nmap <silent> <leader><leader> :NERDTreeToggle<CR>

nnoremap <leader>b :BufExplorer<CR>

""" Plugin Settings

nnoremap <Leader>o :GFiles .<CR>
nnoremap <leader>ff :Files<CR>
nnoremap <Leader>w :wa<CR>

nmap <silent> // :nohlsearch<CR>
noremap ,hl :set hlsearch! hlsearch?<CR>

nmap <C-F>f <Plug>CtrlSFPrompt
vmap <C-F>f <Plug>CtrlSFVwordPath
nmap <C-F>n <Plug>CtrlSFCwordPath
nnoremap <C-F>t :CtrlSFToggle<CR>
inoremap <C-F>t <Esc>:CtrlSFToggle<CR>

augroup common
  autocmd BufEnter * EnableStripWhitespaceOnSave
augroup END

augroup go
  autocmd!
  autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
augroup END

" Move lines up and down
nnoremap Ô :m .+1<CR>==
nnoremap  :m .-2<CR>==
inoremap Ô <Esc>:m .+1<CR>==gi
inoremap  <Esc>:m .-2<CR>==gi
vnoremap Ô :m '>+1<CR>gv=gv
vnoremap  :m '<-2<CR>gv=gv

autocmd FileType vue syntax sync fromstart

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

nmap <silent> <leader>d <Plug>DashSearch

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

nmap <silent> [r <Plug>(coc-diagnostic-prev)
nmap <silent> ]r <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'

nnoremap <Leader>gst :Gstatus<CR>
nnoremap <Leader>gbl :Gblame<CR>

au FileType go nmap <leader>rv <Plug>(go-run-vertical)
let g:go_def_mode = 'gopls'
