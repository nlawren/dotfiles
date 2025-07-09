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

colorscheme sorbet

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

set autoindent
set smartindent
set number
set relativenumber

" Enable syntax highlighting and indentation for JSON
autocmd FileType json setlocal ts=2 sw=2 expandtab

" Enable syntax highlighting and indentation for YAML
autocmd FileType yaml setlocal ts=2 sw=2 expandtab

" Enable syntax highlighting and indentation for Markdown
autocmd FileType markdown setlocal ts=4 sw=4 expandtab

" Python settings
autocmd FileType python setlocal ts=4 sw=4 expandtab
