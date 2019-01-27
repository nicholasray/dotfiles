" setting up vim-plug
call plug#begin('~/.local/share/nvim/plugged')

Plug 'Raimondi/delimitMate'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins', 'commit': 'bf6db3bede2097a0f5572aea19fffc3b98e6a884' }
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'rhysd/vim-grammarous'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'moll/vim-node'
Plug 'digitaltoad/vim-pug'
Plug 'tpope/vim-surround'
Plug 'acarapetis/vim-colors-github'
Plug 'google/vim-searchindex'
Plug 'tpope/vim-sleuth'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'godlygeek/tabular'
Plug 'mustache/vim-mustache-handlebars'
Plug 'w0rp/ale'
Plug 'morhetz/gruvbox'
Plug 'ayu-theme/ayu-vim'
Plug 'mhinz/vim-startify'
Plug 'heavenshell/vim-jsdoc'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'vim-airline/vim-airline'
Plug 'qpkorr/vim-bufkill'
Plug 'vim-airline/vim-airline-themes'
Plug 'rking/ag.vim'
Plug 'jremmen/vim-ripgrep'
Plug 'arcticicestudio/nord-vim'
Plug 'jparise/vim-graphql'
Plug 'roxma/LanguageServer-php-neovim',  {'do': 'composer install && composer run-script parse-stubs'}

" Initialize plugin system
call plug#end()

" Don't show mode in status line
:set noshowmode

" Cycle between windows easily
nmap <tab> <C-W>w

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

filetype plugin indent on

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab

" Display extra whitespace on command
set listchars=tab:»·,trail:·,eol:↵,extends:↷,precedes:↶

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

" Switch to terminal normal mode easily
tnoremap <C-N> <C-\><C-N>

" Use true colors
set termguicolors

let b:mode = 'dark'

if b:mode == 'light'
  " Color scheme
  colorscheme github
  set background=light
  hi Normal guibg=#f5f4fc
  let g:airline_theme='base16'
  let g:NERDTreeHighlightCursorline = 0
endif

if b:mode == 'dark'
  " Turn on cursor highlight line
  set cursorline
  let ayucolor="mirage"
  colorscheme ayu
  set background=dark
  let g:airline_theme='ayu'
  " Make vertical borders darker and more pleasing
  hi VertSplit guibg=bg guifg=#14171F
  hi NonText guifg=#626F7F
  hi SpecialKey guifg=#626F7F
  hi MatchParen gui=bold guibg=#626F7F
  hi link QuickFixLine Normal
endif

let g:airline_extensions = ['branch', 'whitespace']
let g:airline_highlighting_cache = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

" Open up Startify before NERDTree so that startify will work
autocmd VimEnter *
            \   if !argc()
            \ |   Startify
            \ |   NERDTree
            \ |   wincmd w
            \ | endif

let g:startify_change_to_vcs_root = 1

" vim-javascript JSDoc syntax highlighting
let g:javascript_plugin_jsdoc = 1

" Nerdtree
nmap <leader>ne :NERDTree<cr>
" Highlight File in NERDTree
nnoremap <Leader>nf :NERDTreeFind<cr>
" show hidden files
let NERDTreeShowHidden=1
let g:NERDTreeWinPos = "right"
" Hide NERDTree help message
let NERDTreeMinimalUI = 1
" Default NERDTree width
let g:NERDTreeWinSize=30
" expand all directories regardless if they have a single child
let NERDTreeCascadeSingleChildDir=0
" Hide ~ line symbol bc it is ugly
highlight EndOfBuffer guifg=bg
" Open NERDTree automatically
autocmd vimenter * NERDTree
" Switch to main winow when vim starts (not NERDTree)
autocmd VimEnter * wincmd p
" Close Vim automatically if NERDTree is only window left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

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

" Make FZF behave like ctrl-p and prevent fzf from opening in nerdtree buffer
nnoremap <c-p> :FZF<cr>

" Turn off search highlighting easily
nnoremap <Leader>j :noh<cr>

" Deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#file#enable_buffer_path = 1

call deoplete#custom#option({
\ 'auto_complete_delay': 80,
\ 'auto_refresh_delay': 80
\ })

" Disable 'Pattern not Found' messages in command line when Language Client
" returns no results
set shortmess+=c
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"
" close preview after completion
autocmd CompleteDone * pclose!
" tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" Undo / Redo
set undofile
set undodir=~/.config/undo/

" Spell check markdown
autocmd BufRead,BufNewFile *.md setlocal spell

" Enable Mouse Operability in Neovim
set mouse=a

" Fix files with prettier, and then ESLint.
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_fixers = {'javascript': ['prettier', 'eslint'], 'scss': ['prettier']}
let g:ale_fix_on_save = 1
let g:ale_javascript_eslint_suppress_missing_config = 1

let g:LanguageClient_serverCommands = {
    \ 'javascript.jsx': [ 'node', '~/.nvm/versions/node/v10.13.0/lib/node_modules/javascript-typescript-langserver/lib/language-server-stdio.js' ]
    \ }
let g:LanguageClient_diagnosticsEnable=0

nnoremap M :call LanguageClient#textDocument_signatureHelp()<CR>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>

" Open VIMRC
nnoremap <Leader>fvo :e $MYVIMRC<CR>
" Source VIMRC
nnoremap <Leader>fvs :source $MYVIMRC<CR>
" Install vim plugins
nnoremap <Leader>fvI :source $MYVIMRC<CR>:PlugInstall<CR>
" Update vim plugins
nnoremap <Leader>fvU :source $MYVIMRC<CR>:PlugUpdate<CR>
" Clean vim plugins
nnoremap <Leader>fvC :source $MYVIMRC<CR>:PlugClean<CR>
" Open v-split
nnoremap <Leader>wv :vsp<CR>
" Toggle listchars
nnoremap <Leader>tl :set list!<CR>
" Toggle Git Blame
nnoremap <Leader>tg :Gblame<CR>
" Generate JsDoc
nnoremap <Leader>lgd :JsDoc<CR>
" List buffers with fzf
nnoremap <Leader>bl :Buffers<CR>
" Remove current buffer without closing window
nnoremap <Leader>bd :BD<CR>
" Close current window
nnoremap <Leader>wd :q<CR>
" Make search project
nnoremap <Leader>sp :Rg 
" Search word under corsor
nnoremap <expr> <Leader>sc ':Rg ' . expand('<cword>')
" Toggle terminal mode
nnoremap <silent> <Leader>tt :topleft split term://zsh<CR>:resize 5<CR>:set wfh<CR>i
" Increase window height
nnoremap <Leader>wh> :res +10<CR>
" Decrease window height
nnoremap <Leader>wh< :res -10<CR>
" Increase window width
nnoremap <Leader>ww> :vertical resize +10<CR>
" Decrease window width
nnoremap <Leader>ww< :vertical resize -10<CR>

" 'Raw'-version of Ag.
" Prepend `autocmd VimEnter *` if you want to name it Ag
" and override the default command
command! -nargs=+ -complete=file Rag call fzf#vim#ag_raw(<q-args>)

" Prevent Ag from opening first buffer
ca Ag Ag!
