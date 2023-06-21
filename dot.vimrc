" My .vimrc 
" in progress and in draft

set wildmenu

" Always show current position
set ruler

" Height of the command bar
set cmdheight=1

" Configure backspace so it acts as it should act
set backspace=eol,start,indent

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Enable syntax highlighting
syntax enable

colorscheme torte

set background=dark

" Use Unix as the standard file type
set ffs=unix,dos,mac

set nobackup
set noswapfile

" Use spaces instead of tabs
set expandtab
set smarttab

" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %F%m%r%h\ %w\ \ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c

" Enable filetype plugins
filetype plugin on
filetype indent on

autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd BufNewFile,BufRead *.py set tabstop=4 softtabstop=4 shiftwidth=4 expandtab smarttab autoindent



