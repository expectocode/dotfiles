if &compatible
  set nocompatible               " Be iMproved
endif

colorscheme base16-eighties


" Begin dein section
" Required:
set runtimepath+=/home/tanuj/.local/share/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/home/tanuj/.local/share/dein')
  call dein#begin('/home/tanuj/.local/share/dein')

  " Let dein manage dein
  " Required:
  call dein#add('/home/tanuj/.local/share/dein/repos/github.com/Shougo/dein.vim')

  " Rust syntax
  call dein#add('rust-lang/rust.vim')
  " Base 16 colors
  call dein#add('chriskempson/base16-vim')
  " Autoformat for different langs
  call dein#add('Chiel92/vim-autoformat')
  " Dein command
  call dein#add('haya14busa/dein-command.vim')
  " commenting
  call dein#add('tpope/vim-commentary')

  " undo tree
  call dein#add('sjl/gundo.vim')


  " Autocomplete
  call dein#add('Shougo/deoplete.nvim')
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif
  " Deoplete Rust
  "call dein#add('sebastianmarkow/deoplete-rust')

  " julia
  call dein#add('JuliaEditorSupport/julia-vim')


  call dein#add('autozimu/LanguageClient-neovim', {
      \ 'rev': 'next',
      \ 'build': 'bash install.sh',
      \ })

  " Alignment
  call dein#add('tommcdo/vim-lion')

  " Startup profiler
  call dein#add('tweekmonster/startuptime.vim')

  " Git assist
  call dein#add('tpope/vim-fugitive')

  "Emoji insertion
  "actually, no.
  "call dein#add('fszymanski/deoplete-emoji')

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------

" Deoplete
call deoplete#enable()
let g:deoplete#sources#rust#racer_binary='/home/tanuj/.cargo/bin/racer'
let g:deoplete#sources#rust#rust_source_path='/home/tanuj/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src'

" Required for operations modifying multiple buffers like rename.
set hidden

let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'stable', 'rls'],
    \ 'python': ['pyls'],
\ }

" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" gundo
nnoremap <F2> :GundoToggle<CR>

" End deoplete

" display settings
set encoding=utf-8 " encoding used for displaying file
set ruler " show the cursor position all the time
set showmatch " highlight matching braces
set showmode " show insert/replace/visual mode
set showcmd
" i think this is to do with line wrap doing words
set formatoptions+=1
set lbr

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

" search settings
set hlsearch " highlight search results
set ignorecase " do case insensitive search...
set incsearch " do incremental search
set smartcase " ...unless capital letters are used
nnoremap <esc> :noh<return><esc>
" make esc stop the highlighting

" terminal settings
set scrollback=10000

" file type specific settings
"filetype on " enable file type detection - vundle doesnt like this on
filetype plugin on " load the plugins for specific file types
filetype indent on " automatically indent code


" automatic commands
if has('autocmd')
        " file type specific automatic commands

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

" center view on the search result
noremap n nzz
noremap N Nzz


" Put these lines at the very end of your vimrc file, for plugin :help

" Load all plugins now.
" Plugins need to be added to runtimepath before helptags can be generated.
packloadall
" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL
