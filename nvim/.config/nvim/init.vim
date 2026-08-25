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

  " Fuzzy finder
  Plug 'ibhagwan/fzf-lua'

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
  Plug 'mbbill/undotree'

  " Now we're really IDE: file tree
  Plug 'nvim-tree/nvim-tree.lua'
  Plug 'akinsho/bufferline.nvim'

  Plug 'famiu/bufdelete.nvim'

  " Tabulize data
  Plug 'godlygeek/tabular'

  " nix
  Plug 'LnL7/vim-nix'

  " LSP
  Plug 'neovim/nvim-lspconfig'
  Plug 'saghen/blink.cmp', { 'tag': 'v1.*' }

  " Alignment
  Plug 'tommcdo/vim-lion'

  " Startup profiler
  Plug 'tweekmonster/startuptime.vim'

  " Git assist
  Plug 'tpope/vim-fugitive'

call plug#end()
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

"End vim-plug -------------------------

" Buffer line config
lua << EOF
require('bufferline').setup({
  options = {
    offsets = { { filetype = 'NvimTree', text = 'Files' } },

    diagnostics = 'nvim_lsp',
    diagnostics_update_in_insert = false,
    diagnostics_indicator = function(count, level)
      return (level:match('error') and ' E' or ' W') .. count
    end,

    -- plain-text icons, no Nerd Font required
    buffer_close_icon = 'x',
    close_icon = 'X',
    modified_icon = '+',
    separator_style = { '|', '|' },
  },
})
EOF
nnoremap <S-l> :BufferLineCycleNext<CR>
nnoremap <S-h> :BufferLineCyclePrev<CR>

nnoremap <C-;> <cmd>Bdelete<CR>

lua << EOF
require('nvim-tree').setup({
  view = { width = 32 },
  update_focused_file = { enable = true },
  renderer = { icons = { show = { file = false, folder = false } } }, -- no icons
})
EOF
nnoremap <F3> :NvimTreeToggle<CR>

lua << EOF
-- completion engine
require('blink.cmp').setup({
  keymap = {
      preset = 'enter',
      ['<Tab>'] = { 'select_next', 'fallback' },
      ['<S-Tab>'] = { 'select_prev', 'fallback' },
  },
  sources = { default = { 'lsp', 'path', 'snippets', 'buffer' } },
  fuzzy = { implementation = 'lua' },
   completion = {
      list = {
        selection = { preselect = false, auto_insert = true },
      },
    },
})

-- LSPs with no entry in nvim-lspconfig's catalogue
vim.lsp.config('zubanls', {
  cmd = { 'zuban', 'server' },
  filetypes = { 'python' },
  root_markers = { 'pyproject.toml', 'mypy.ini', 'setup.cfg', '.git' },
})

vim.lsp.enable({ 'rust_analyzer', 'clangd', 'gopls', 'ruff', 'zubanls', 'djlsp' })

vim.diagnostic.config({
  virtual_lines = { current_line = true },
  underline = true,
  severity_sort = true,
})
vim.o.completeopt = 'menu,menuone,noselect'
vim.o.winborder='rounded'

-- hover, because dvorak remaps have taken K
vim.keymap.set('n', 'M', vim.lsp.buf.hover)
vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format() end)
EOF


" Colorscheme has to come after plug#end() so base16-vim is on the runtimepath.
" silent! so a fresh install without the plugin yet doesn't throw.
set termguicolors
silent! colorscheme base16-eighties

" has to come after colorscheme
highlight BufferLineBufferSelected gui=NONE

" Autoformat
let g:formatdef_prettier_ts = "'npx prettier --parser typescript'"
let g:formatters_typescript = ['prettier_ts']
let g:formatters_typescriptreact = ['prettier_ts']
let g:formatdef_djlint = '"djlint --reformat --quiet -"'
let g:formatters_htmldjango = ['djlint']

" let g:rustfmt_command="rustfmt --edition 2021"
" Cargo fmt
nmap <C-f> :Autoformat<CR>

" rg for grep
set grepprg=rg\ --vimgrep\ --smart-case
set grepformat=%f:%l:%c:%m

nnoremap <C-p> <cmd>FzfLua live_grep<cr>
nnoremap <C-a> <cmd>FzfLua files<cr>
nnoremap <C-b> <cmd>FzfLua buffers<cr>
nnoremap <C-s> <cmd>FzfLua lsp_document_symbols<cr>

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

" gundo
nnoremap <F2> :UndotreeToggle<CR>
set undofile
set undodir=~/.local/state/nvim/undo

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

" show trailing whitespace
set list
set listchars=trail:-

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


" file type specific automatic commands
autocmd FileType typescript,typescriptreact setlocal shiftwidth=2 softtabstop=2

" set djangohtml filetype
autocmd BufRead,BufNewFile */templates/*.html setfiletype htmldjango

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

" Insert close brace when typing open brace
inoremap {<CR> {<CR>}<C-o>O

" vim-plug generates helptags on install/update, so these aren't needed for
" the plugins above. Kept in case anything lives in
packloadall
silent! helptags ALL

endif " VS code
