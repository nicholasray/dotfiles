" setting up vim-plug
call plug#begin('~/.local/share/nvim/plugged')

Plug 'Raimondi/delimitMate'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'pangloss/vim-javascript'
Plug 'tpope/vim-surround'
Plug 'google/vim-searchindex'
Plug 'tpope/vim-sleuth'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'mustache/vim-mustache-handlebars'
Plug 'ayu-theme/ayu-vim'
Plug 'mhinz/vim-startify'
Plug 'heavenshell/vim-jsdoc'
Plug 'vim-airline/vim-airline'
Plug 'qpkorr/vim-bufkill'
Plug 'vim-airline/vim-airline-themes'
Plug 'rking/ag.vim'
Plug 'jremmen/vim-ripgrep'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dart-lang/dart-vim-plugin'
Plug 'reisub0/hot-reload.vim'
Plug 'posva/vim-vue'

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

" Turn on cursor highlight line
set cursorline
let ayucolor="mirage"
colorscheme ayu
set background=dark
let g:airline_theme='ayu_mirage'


" Make vertical borders darker and more pleasing
hi Normal guibg=#1E2431
hi VertSplit guibg=bg guifg=#14171F
hi NonText guifg=#626F7F
hi SpecialKey guifg=#626F7F
hi MatchParen gui=bold guibg=#626F7F
hi SignColumn guibg=bg
hi link QuickFixLine Normal

let g:airline_extensions = ['branch', 'coc']
let g:airline_highlighting_cache = 0

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

" Undo / Redo
set undofile
set undodir=~/.config/undo/

" Spell check markdown
autocmd BufRead,BufNewFile *.md setlocal spell

" Enable Mouse Operability in Neovim
set mouse=a

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Better display for messages and avoid 'Press ENTER or type command to continue
" from echo messages being too long
set cmdheight=1

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

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

" Use <c-space> for trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use gh for show documentation in preview window
nnoremap <silent> gh :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"
let g:coc_snippet_next = '<TAB>'
let g:coc_snippet_prev = '<S-TAB>'
augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" - fzf#vim#grep(command, with_column, [options], [fullscreen])
command! -bang -nargs=* Fly call fzf#vim#grep('rg --color=never --line-number '.shellescape(<q-args>), 0, fzf#vim#with_preview({'options': '-n 3.. --exact --no-multi --delimiter :'}), <bang>0)

" Open CocConfig
nnoremap <Leader>fco :CocConfig<CR>

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
" Organize imports
nnoremap <Leader>or :OR<CR>
" Make search project
nnoremap <Leader>sf :Fly<CR>
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
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap <Leader>a <Plug>(EasyAlign)
" Open Markdown Preview 
nnoremap <Leader>fmo :MarkdownPreview<CR>

" Some of these key choices were arbitrary;
" it's just an example.
nnoremap <leader>fa :FlutterRun<cr>
nnoremap <leader>fq :FlutterQuit<cr>
nnoremap <leader>fr :FlutterHotReload<cr>
nnoremap <leader>fR :FlutterHotRestart<cr>
nnoremap <leader>fD :FlutterVisualDebug<cr>

" Prevent Ag from opening first buffer
ca Ag Ag!
