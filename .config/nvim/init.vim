

if !&compatible
  set nocompatible
endif

" dein自体の自動インストール
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif
let &runtimepath = s:dein_repo_dir .",". &runtimepath
" プラグイン読み込み＆キャッシュ作成
let s:toml_file = fnamemodify(expand('<sfile>'), ':h').'/dein.toml'
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  call dein#load_toml('~/.config/nvim/dein.toml')
  call map(dein#check_clean(), "delete(v:val, 'rf')")
  call dein#end()
  call dein#save_state()
endif
" 不足プラグインの自動インストール
if dein#check_install()
  call dein#install()
endif

set number
set autoindent
set tabstop=2
set expandtab
set shiftwidth=2
set splitright
set clipboard=unnamed


"encoding
set encoding=utf-8
scriptencoding utf-8
set termencoding=utf-8
set fileencodings=utf-8,euc-js,sjis
set fileformats=unix,dos,mac


"検索
set ignorecase
set smartcase
set wrapscan
set hlsearch


"補完
set wildignorecase
set wildmode=list:longest
set pumheight=10
set wildmenu
set completeopt=menuone,noinsert


"表示
set number
set cursorline
set title
set display=lastline
set wrap
set ruler
set list
set listchars=tab:>.,trail:-,nbsp:%
set ambiwidth=double
set noshowmode

"色
syntax on
set t_Co=256
set background=dark
"highlight Normal ctermbg=none
set termguicolors

"そのほか
set mouse=a
set confirm
set nobackup
set noswapfile
set hidden
set laststatus=2
set showmatch
set matchtime=1
set showcmd
set smartindent
set whichwrap=b,s,h,l,[,],<,>
set backspace=indent,eol,start
set splitbelow
set splitright

set autoread

autocmd FileType * setlocal formatoptions-=ro


"Keymap
nmap - $
nnoremap <C-l> :nohl<CR>

inoremap jj <ESC>
inoremap <C-@> <ESC>

imap <C-j> <down>
imap <C-k> <up>
imap <C-h> <left>
imap <C-l> <right>

nmap j gj
nmap k gk
nmap <down> gj
nmap <up> gk

imap <C-a> <ESC>:w<CR>i
imap <C-w> <ESC>w<CR>
nmap S :w<CR>
nmap <C-a> :w<CR>

nmap s <Nop>
nmap sj <C-w>j
nmap sk <C-w>k
nmap sl <C-w>l
nmap sh <C-w>h
nmap sJ <C-w>J
nmap sK <C-w>K
nmap sL <C-w>L
nmap sH <C-w>H

nmap sn gt
nmap sp gT
nmap sr <C-w>r
nmap s= <C-w>=
nmap sw <C-w>w
nmap so <C-w>_<C-w>|
nmap sO <C-w>=
nmap sN :<C-u>bn<CR>
nmap sP :<C-u>bp<CR>
nmap st :<C-u>tabnew<CR>
nmap sT :<C-u>Unite tab<CR>
nmap ss :<C-u>sp<CR>
nmap sv :<C-u>vs<CR>
nmap sq :<C-u>q<CR>
nmap sQ :<C-u>bd<CR>

