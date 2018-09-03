" setting up vim-plug
call plug#begin('~/.local/share/nvim/plugged')

Plug 'rking/ag.vim'
Plug 'Raimondi/delimitMate'
Plug 'zchee/deoplete-go'
Plug 'carlitux/deoplete-ternjs'
Plug 'Shougo/deoplete.nvim'
Plug 'scrooloose/nerdtree'
Plug 'vim-syntastic/syntastic'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'fatih/vim-go'
Plug 'rhysd/vim-grammarous'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'moll/vim-node'
Plug 'prettier/vim-prettier'
Plug 'digitaltoad/vim-pug'
Plug 'tpope/vim-surround'
Plug 'acarapetis/vim-colors-github'
Plug 'fatih/vim-go'
Plug 'google/vim-searchindex'
Plug 'tpope/vim-sleuth'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
Plug 'godlygeek/tabular'
Plug 'mustache/vim-mustache-handlebars'

" Initialize plugin system
call plug#end()

" Leader
let mapleader = " "

set clipboard+=unnamedplus
set backspace=2   " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

" Disable cursor from changing
set guicursor=

" Syntastic options
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_check_on_open = 1

" Flow
let g:javascript_plugin_flow = 1
" JSDoc
let g:javascript_plugin_jsdoc = 1

filetype plugin indent on

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" Display extra whitespace on command
set listchars=tab:»·,trail:·,nbsp:·

" Use one space, not two, after punctuation.
set nojoinspaces

" Make it obvious where 80 characters is
set textwidth=80
autocmd bufreadpre *.pug setlocal textwidth=0
set colorcolumn=+1

" Make git commit messages be 72 characters wide
au FileType gitcommit set tw=72

" Numbers
set number
set numberwidth=5

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
inoremap <S-Tab> <c-n>

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Use true colors
set termguicolors

" Color scheme
colorscheme github

let g:lightline = {
  \   'colorscheme': 'powerline_custom',
  \   'active': {
  \     'left':[ [ 'mode', 'paste' ],
  \              [ 'gitbranch', 'readonly', 'filename', 'modified' ]
  \     ]
  \   },
  \   'component_function': {
  \     'filename': 'FilenameForLightline',
  \     'gitbranch': 'fugitive#head',
  \     'fileformat': 'LightlineFileformat',
  \     'filetype': 'LightlineFiletype'
  \   }
  \ }

function! LightlineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! FilenameForLightline()
  return expand('%')
endfunction

" Nerdtree
nmap <leader>ne :NERDTree<cr>
" show hidden files
let NERDTreeShowHidden=1
" open nerdtree automatically when vim starts if no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" expand all directories regardless if they have a single child
let NERDTreeCascadeSingleChildDir=0

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor
endif

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Make FZF behave like ctrl-p
nnoremap <C-p> :GFiles<cr>

" Turn off search highlighting easily
nnoremap <Leader>j :noh<cr>

" Deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#file#enable_buffer_path = 1
let g:deoplete#sources#ternjs#types = 1

inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

" close preview after completion
autocmd CompleteDone * pclose!
" tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" Vim-go
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"

autocmd FileType go setlocal nolist

let g:syntastic_go_checkers = ['go']
let g:go_list_type = "quickfix"

" Undo / Redo
set undofile
set undodir=~/.config/undo/

" Spell check markdown
autocmd BufRead,BufNewFile *.md setlocal spell

" Enable Mouse Operability in Neovim
set mouse=a

" Prevent Ag from opening first result
ca Ag Ag!

" Prettier stuff
" let g:prettier#autoformat = 0
" autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.graphql,*.md,*.vue PrettierAsync

