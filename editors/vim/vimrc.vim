"--------------------
" Dylan Thomas' vimrc
"--------------------

" Ensure we are explicit about not using Vi, but Vim!
set nocompatible

"----------------
" Feature Testing
"----------------

"set synmaxcol=200               " only highlight first 200 columns
"set list                        " Show non-printable characters (returns, etc)

"---------------
" Initialization
"---------------

" Auto-check that vim-plug (plugin manager) is installed. If not
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Source the file that holds our plugins
if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

let mapleader =","              " set leader for key combos
filetype plugin indent on       " force these

"----------
" Wild menu
"----------

set wildignore=*.o,*~,*.pyc     " Ignore compiled files
set wildignore+=*/.git/*        " Ignore git files
set wildignore+=*/.vscode/*     " Ignore vscode files
set wildignore+=*/.DS_Store     " Ignore Mac files
set wildmenu                    " command completion help

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<Tab>"
    else
        return "\<C-p>"
    endif
endfunction
inoremap <Tab> <C-r>=InsertTabWrapper()<CR>
inoremap <S-Tab> <C-n>

"-------------
" Color scheme
"-------------

syntax on
" vim can autodetect this based on $TERM (e.g. 'xterm-256color')
" but it can be set to force 256 colors
" set t_Co=256
if has('gui_running')
    set background=dark
    colorscheme solarized
    let g:lightline = {'colorscheme': 'solarized'}
elseif &t_Co < 256
    colorscheme default
    set nocursorline " looks bad in this mode
else
    set background=dark
    let g:solarized_termcolors=256 " instead of 16 color with mapping in terminal
    colorscheme solarized
    " customized colors
    highlight SignColumn ctermbg=234
    highlight StatusLine cterm=bold ctermfg=245 ctermbg=235
    highlight StatusLineNC cterm=bold ctermfg=245 ctermbg=235
    highlight SpellBad cterm=underline
endif

"-------------------
" Indentation & Text
"-------------------

set autoindent                  " indent according to previous line
set expandtab                   " use spaces instead of tabs
set tabstop=4                   " visual spaces ber TAB
set softtabstop=4               " tab key indents 4 spaces
set shiftwidth=4                " >> indents 4 spaces
set shiftround                  " >> indents to next multiple of `shiftwidth`

" Linebreak, textwidth, and wordwrap
set linebreak
set textwidth=100
set colorcolumn=101             " Create colored column at textwidth
set wrap

"--------------------
" Basic editor config
"--------------------

set number                      " line numbers
set numberwidth=5               " width of line number column
set showmode                    " show current mode
set showcmd                     " show already type keys
set scrolloff=7                 " scroll offset to keep cursor visible
set ruler                       " Always show position
set cmdheight=2                 " height of command bar
set showmatch                   " show matching [{(
set mat=4                       " tenths of a second to show matching braces
set foldcolumn=3                " Extra margin on left
set history=500                 " how many lines VIM remembers
set report=0                    " always report changed lines
set autoread                    " read when file is changed from outside
set noerrorbells                " No annoying sounds
set encoding=utf-8              " utf8 standard encoding8
set modelines=0                 " Turns modelines off for security
set modeline                    " Turns modelines off for security
set backspace=indent,eol,start  " make backspace work as you would expect
set whichwrap+=<,>,h,l
set nojoinspaces " suppress inserting two spaces between sentences
set mouse+=a " enable mouse mode (scrolling, selection, etc)

"------------
" Status line
"------------

set display=lastline            " show as much as possible of last line
set laststatus=2                " always show statusline
" Format status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c

"----------------------------
" Graphics & Windows Behavior
"----------------------------

set ttyfast                     " faster redrawing
set lazyredraw                  " only redraw as needed
set hidden                      " switch between buffers w/o having to save
set splitbelow                  " open new windows below current
set splitright                  " open new windoes right of current

"----------
" Searching
"----------

set incsearch                   " highlight while search
set hlsearch                    " keep matches highlighted
set wrapscan                    " search wraps around end-of-file
set ignorecase                  " ignore capitalization
set smartcase                   " don't ignore case if contains uppercase letter
" Disable highlight when <leader><cr> is pressed
nnoremap <silent> <leader><cr> :nohlsearch<cr>

"-------------
" Code Folding
"-------------

set foldmethod=syntax           " fold based on indent`
set foldlevelstart=6            " open most folds by default
set foldnestmax=10              " only nest 10 folds
set foldenable                  " enables folding
" Remap fold toggle
nnoremap <space> za

"-----------
" Remappings
"-----------

" fast saving (forced) & quitting (not forced)
nnoremap <leader>w :w!<cr>
nnoremap <leader>q :q<cr>

" :W saves the file using sudo
command! W w !sudo tee % > /dev/null 

" Remove Windows ^M - when encodings messed up
nnoremap <leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Toggle paste mode
nnoremap <leader>pp :setlocal paste!<cr>

" highlight last inserted text
nnoremap gV `[v`]

" save session for next time VIM opened (Reopens with "vim -S")
nnoremap <leader>s :makesession<cr>

" Remap Escape key to 'jk'. Make sure not to put this comment on same line!
inoremap jk <Esc>`^

" Movement

" Get off my lawn
"nnoremap <Left> :echoe "Use h"<CR>
"nnoremap <Right> :echoe "Use l"<CR>
"nnoremap <Up> :echoe "Use k"<CR>
"nnoremap <Down> :echoe "Use j"<CR>

" Remap visual line jumps
map j gj
map k gk

" Easier movement btwn windows
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

" Close current buffer, all buffers resp.
nnoremap <leader>bd :Bclose<cr>:tabclose<cr>gT
nnoremap <leader>ba :bufdo bd<cr>

" Buffer movement (next, prev) resp.
nnoremap <leader>l :bnext<cr>
nnoremap <leader>h :bprevious<cr>

" Tab management (new, keep only, close, move, next)
nnoremap <leader>tn :tabnew<cr>
nnoremap <leader>to :tabonly<cr>
nnoremap <leader>tc :tabclose<cr>
nnoremap <leader>tm :tabmove
nnoremap <leader>t<leader> :tabnext

" Open new tab w/ current buffer path
nnoremap <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch cwd to directory of open buffer
nnoremap <leader>cd :cd %:p:h<cr>:pwd<cr>

" Return to last edit position when opening files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

"---------------
" Spell checking
"---------------

" Pressing ,ss will toggle spell check
nnoremap <leader>ss :setlocal spell!<cr>

" Shortcuts for spell check
nnoremap <leader>sn ]s
nnoremap <leader>sp [s
nnoremap <leader>sa zg
nnoremap <leader>s? z=

"------------------------
" Edit/source vimrc/zshrc
"------------------------

nnoremap <leader>ev :vsp $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>ez :vsp ~/.zshrc<cr>

"-----------
" Autogroups
"-----------

" highlight current line, but only in active window
augroup CursorLineOnlyInActiveWindow
    autocmd!
    autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline
augroup END

augroup configgroup
    " Directive clears all autocmds for group
    autocmd!
    " Whitespace removal
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee,*.zsh :call CleanExtraSpaces()
    " Python
    autocmd FileType python setlocal commentstring=#\ %s
    " Ensure TABs are used in makefiles
    autocmd BufEnter Makefile setlocal noexpandtab 
    autocmd BufEnter makefile setlocal noexpandtab
    autocmd BufEnter *.mk setlocal noexpandtab
    autocmd BufEnter make setlocal noexpandtab
    " Reset shell script tabbing
    autocmd BufEnter *.sh setlocal tabstop=2
    autocmd BufEnter *.sh setlocal shiftwidth=2
    autocmd BufEnter *.sh setlocal softtabstop=2
augroup end

augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd BufRead,BufNewFile aliases.local,zshrc.local,*/zsh/configs/* set filetype=sh
  autocmd BufRead,BufNewFile gitconfig.local set filetype=gitconfig
  autocmd BufRead,BufNewFile tmux.conf.local set filetype=tmux
  autocmd BufRead,BufNewFile vimrc.local, vimrc.bundles set filetype=vim
augroup END

"----------------
" Plugin Settings
"----------------

" Requires Ack, Ag be installed & ack.vim loaded
" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Set Ack to use Ag
  let g:ackprg = 'ag --vimgrep --smart-case'
  " Remap command for searching
    nnoremap <leader>a :Ack

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag --literal --files-with-matches --nocolor --hidden -g "" %s'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0

  if !exists(":Ag")
    command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
    nnoremap \ :Ag<SPACE>
  endif
endif

"----------------
" File management
"----------------

set backup
set backupdir   =$HOME/.vim/files/backup/
set backupext   =-vimbackup
set backupskip  =
set directory   =$HOME/.vim/files/swap/
set updatecount =100
set undofile
set undodir     =$HOME/.vim/files/undo/
set viminfo     ='100,n$HOME/.vim/files/info/viminfo

"-----------------
" Custom functions
"-----------------

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

" Delete trailing whitespace on save, for filetypes
function! <SID>CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfunction

" Buffer close command
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction

" Needs desc
function! CmdLine(str)
    call feedkeys(":" . a:str)
endfunction

" Improve location lists!
function! <SID>LocationPrevious()
    try
        lprev
    catch /^Vim\%((\a\+)\)\=:E553/
        llast
    endtry
endfunction

" Improve location lists!
function! <SID>LocationNext()
    try
        lnext
    catch /^Vim\%((\a\+)\)\=:E553/
        lfirst
    endtry
endfunction

nnoremap <silent> <Plug>LocationPrevious    :<C-u>exe 'call <SID>LocationPrevious()'<cr>
nnoremap <silent> <Plug>LocationNext        :<C-u>exe 'call <SID>LocationNext()'<cr>

"------------------------
" Enable local overwrites
"------------------------
let $LOCALFILE=expand("~/.vimrc_local")
if filereadable($LOCALFILE)
    source $LOCALFILE
endif
