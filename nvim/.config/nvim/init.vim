if &compatible
  set nocompatible               " Be iMproved
endif

""" Top stuff applies to VS Code too.

" search settings
set hlsearch " highlight search results
set ignorecase " do case insensitive search...
set smartcase " ...unless capital letters are used
set incsearch " do incremental search

nnoremap <esc> :noh<return><esc>
" make esc stop the highlighting

" HJKL but dvorak
noremap s l
noremap n j
noremap t k
noremap h h

noremap j t
noremap J T

noremap x s

nnoremap T :join<CR>

" man page M
noremap M K

" center view on the search result
noremap k nzz
noremap K Nzz

if !exists('g:vscode')  " nearly everything should be non-vscode

" Begin vim-plug section -------------------------

" Bootstrap vim-plug itself if it isn't installed yet
let s:plug_file = stdpath('data') . '/site/autoload/plug.vim'
if empty(glob(s:plug_file))
  silent execute '!curl -fLo ' . shellescape(s:plug_file) . ' --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(stdpath('data') . '/plugged')

  " Command completion
  Plug 'Shougo/denite.nvim'
  " , { 'on': ['Denite', 'DeniteBufferDir', 'DeniteCursorWord', 'DeniteProjectDir'] }

  " Fuzzy finder
  Plug 'ctrlpvim/ctrlp.vim'

  " Rust syntax
  Plug 'rust-lang/rust.vim'

  " Elixir
  Plug 'elixir-editors/vim-elixir'

  " Class outline viewer
  Plug 'majutsushi/tagbar'

  " QML syntax
  Plug 'peterhoeg/vim-qml'

  " Go syntax
  Plug 'fatih/vim-go'

  " Haskell syntax
  Plug 'neovimhaskell/haskell-vim'

  " TOML syntax
  Plug 'cespare/vim-toml'

  " Pest syntax
  Plug 'pest-parser/pest.vim'

  " Base 16 colors
  Plug 'chriskempson/base16-vim'

  " Autoformat for different langs
  Plug 'vim-autoformat/vim-autoformat'

  " commenting
  Plug 'tpope/vim-commentary'
  " surroundings
  Plug 'tpope/vim-surround'

  " undo tree
  Plug 'sjl/gundo.vim'

  " Tabulize data
  Plug 'godlygeek/tabular'

  " nix
  Plug 'LnL7/vim-nix'

  " LSP
  " Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

  Plug 'autozimu/LanguageClient-neovim', {
      \ 'branch': 'next',
      \ 'do': 'bash install.sh',
      \ }

  " To quickly go back from "go to definition"
  Plug 'ipod825/vim-tabdrop'

  " Alignment
  Plug 'tommcdo/vim-lion'

  " Startup profiler
  Plug 'tweekmonster/startuptime.vim'

  " Git assist
  Plug 'tpope/vim-fugitive'

  "Emoji insertion
  "actually, no.
  "Plug 'fszymanski/deoplete-emoji'

call plug#end()
" plug#end() runs `filetype plugin indent on` and `syntax enable` for you,
" and auto-installs anything listed above that isn't fetched yet.

"End vim-plug Scripts-------------------------

" Colorscheme has to come after plug#end() so base16-vim is on the runtimepath.
" silent! so a fresh install without the plugin yet doesn't throw.
silent! colorscheme base16-eighties

" Autoformat
let g:formatdef_prettier_ts = "'npx prettier --parser typescript'"
let g:formatters_typescript = ['prettier_ts']
let g:formatters_typescriptreact = ['prettier_ts']

" Deoplete
" call deoplete#enable()
" let g:deoplete#sources#rust#racer_binary='/home/tanuj/.cargo/bin/racer'
" let g:deoplete#sources#rust#rust_source_path='/home/tanuj/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src'

" deoplete tab-complete
" inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" Go to definition on C-], return on C-t
nnoremap <C-]> :call Gotodef()<CR>
nmap <C-t> :TabdropPopTag<Cr>

function! Gotodef()
    TabdropPushTag
    call LanguageClient_textDocument_definition({'gotoCmd': 'Tabdrop'})
endfunction

" Denite up/down
call denite#custom#map('insert', 'j', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('insert', 'k', '<denite:move_to_previous_line>', 'noremap')
map <space>bb :Denite buffer<cr>

" let g:rustfmt_command="rustfmt --edition 2021"
" Cargo fmt
nmap <C-f> :Autoformat<CR>

" CtrlP
let g:ctrlp_follow_symlinks = 1
" let g:ctrlp_show_hidden = 1
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" Tagbar
nmap <F8> :TagbarToggle<CR>

" Required for operations modifying multiple buffers like rename.
set hidden

set completeopt-=preview  " annoying preview window behaviour when completing


" Window split navigation with Ctrl + hjkl
nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-j> :wincmd j<CR>
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-l> :wincmd l<CR>

" split resizing with Ctrl + arrows
nmap <silent> <C-Up> :resize -5<CR>
nmap <silent> <C-Down> :resize +5<CR>
nmap <silent> <C-Left> :vertical resize +5<CR>
nmap <silent> <C-Right> :vertical resize -5<CR>

let g:LanguageClient_serverCommands = {
    \ 'rust': ['rust-analyzer'],
    \ 'python': ['pyls'],
    \ 'cpp': ['clangd'],
\ }

" gundo
nnoremap <F2> :GundoToggle<CR>

" display settings
set encoding=utf-8 " encoding used for displaying file
set ruler " show the cursor position all the time
set showmatch " highlight matching braces
set showmode " show insert/replace/visual mode
set showcmd
" i think this is to do with line wrap doing words
set formatoptions+=1
set lbr

set number
" set relativenumber
set colorcolumn=100
set cursorline
hi CursorLine ctermbg=235
highlight ColorColumn ctermbg=235

set wildmode=longest,list,full
set wildmenu

" write settings
set confirm " confirm :q in case of unsaved changes
set fileencoding=utf-8 " encoding used when saving file
set nobackup " do not keep the backup~ file


" edit settings
set backspace=indent,eol,start " backspacing over everything in insert mode
set expandtab " fill tabs with spaces
set nojoinspaces " no extra space after '.' when joining lines
set shiftwidth=4 " set indentation depth to X columns
set softtabstop=4 " backspacing over X spaces like over tabs
set tabstop=4 " set tabulator length to X columns
" set textwidth=80 " wrap lines automatically at 80th column
set mouse=a
let mapleader = ","

" terminal settings
set scrollback=10000

" file type specific settings
"filetype on " enable file type detection
filetype plugin on " load the plugins for specific file types
filetype indent on " automatically indent code


" automatic commands
if has('autocmd')
        " file type specific automatic commands
        "
        autocmd FileType typescript,typescriptreact setlocal shiftwidth=2 softtabstop=2

        " Jamal FPSP simulator source files
        autocmd BufRead,BufNewFile *.jss setlocal filetype=jss


        " disable automatic code indentation when editing TeX and XML files
        autocmd FileType tex,xml setlocal indentexpr=

        " Disable expandtab for Go
        autocmd FileType go setlocal noexpandtab

        " clean-up commands that run automatically on write; use with caution

        " delete empty or whitespaces-only lines at the end of file
        autocmd BufWritePre * :%s/\(\s*\n\)\+\%$//ge

        " replace groups of empty or whitespaces-only lines with one empty line
        "autocmd BufWritePre * :%s/\(\s*\n\)\{3,}/\r\r/ge

        " delete any trailing whitespaces
        autocmd BufWritePre * :%s/\s\+$//ge
endif

" Insert close brace when typing open brace
inoremap {<CR> {<CR>}<C-o>O

" vim-plug generates helptags on install/update, so these aren't needed for
" the plugins above. Kept in case anything lives in 
packloadall
silent! helptags ALL

endif " VS code
