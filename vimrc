call pathogen#runtime_append_all_bundles()

set nocompatible               " be iMproved

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" Bundles

Bundle 'danro/rename.vim'
Bundle 'ervandew/supertab'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-rake'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-haml'
Bundle 'vim-ruby/vim-ruby'
Bundle 'wincent/Command-T'
Bundle 'altercation/vim-colors-solarized'
Bundle 'thoughtbot/vim-rspec'
Bundle 'vim-scripts/tComment'
Bundle 'vim-scripts/greplace.vim'
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle 'tomtom/tlib_vim'
Bundle "garbas/vim-snipmate"
Bundle 'jelera/vim-javascript-syntax'
Bundle "pangloss/vim-javascript"
Bundle "scrooloose/syntastic.git"
Bundle 'tpope/vim-bundler'
Bundle 'rking/ag.vim'
Bundle 'mklabs/grunt.vim.git'
Bundle 'kchmck/vim-coffee-script'
Bundle 'roman/golden-ratio'
Bundle "honza/vim-snippets"
Bundle "alexaitken/js-snippets"
Bundle 'jgdavey/tslime.vim'

filetype plugin indent on     " required!

""""""""""""
" Basic Editing Configuation
""""""""""""
set hidden
set wildmode=longest,list
set wildmenu
set showcmd
set ruler
set cursorline
set relativenumber
set laststatus=2
syntax on

set background=dark
let g:solarized_termtrans=1
let g:solarized_termcolors = 16
let g:solarized_contrast = "high"
colorscheme solarized

set cmdheight=2
set history=10000

set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set backspace=indent,eol,start
" enable language dependant indenting
filetype plugin indent on

set ignorecase smartcase
" Prevent Vim from clobbering the scrollback buffer. See
" http://www.shallowsky.com/linux/noaltscreen.html
set t_ti= t_te=

set scrolloff=3

" Store temporary files in a central spot
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" Splits
set splitright
set splitbelow

let mapleader=","

"""""""""""""""""""""""""""
" Mappings
"""""""""""""""""""""""""""

" Move around splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

nmap <leader>ww <C-W>_<C-W>\|

" Clear the search buffer when hitting return
function! MapCR()
  nnoremap <cr> :nohlsearch<cr>
endfunction
call MapCR()

" Switch between the last two files
nnoremap <leader><leader> <c-^>

command! Wq wq
command! Tig !tig

map <f1> <esc>
imap <f1> <esc>

nmap <c-s> <esc>:w<CR>
imap <c-s> <esc>:w<CR>

nmap <c-q> <esc>:q<CR>

" ESC to <c-c>
map <c-c> <esc>
map! <c-c> <esc>

" rspec configuration
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

function! RspecCommand()
  if findfile(".zeus.sock", ".") == ".zeus.sock"
    return "zeus rspec {spec}"
  else
    return "bundle exec rspec {spec}"
  endif
endfunction

function! SetRspecCommand()
  if findfile(".zeus.sock", ".") == ".zeus.sock"
    let g:rspec_command = "!" . RspecCommand()
  else
    let g:rspec_command = "!" . RspecCommand()
  endif
endfunction
call SetRspecCommand()

function! SendRspecToTmux()
  let g:rspec_command = 'call Send_to_Tmux("' . RspecCommand() . '\n")'
endfunction

nmap <leader>mr <Plug>SetTmuxVars

nmap <leader>ut :call Send_to_Tmux("bundle exec ruby -Itest " . expand('%') .  "\n")<CR>
nmap <leader>st :call Send_to_Tmux("bundle exec spring testunit " . expand('%') .  "\n")<CR>

" convert string to symbol
nmap <leader>k ds"ds'lbi:<esc>E
imap <leader>k <esc>ds"ds'lbi:<esc>Ea

" Git work in progress
nmap <leader>gw :Git add .<CR>:Gcommit -m "WIP"<CR>

" CommandT remaps
map <Leader>f :CommandT<CR>
let g:CommandTWildIgnore=&wildignore . ",tmp/*,log/*,coverage/*,generated/*,node_modules/*"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ARROW KEYS ARE UNACCEPTABLE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" map <Left> <Nop>
" map <Right> <Nop>
" map <Up> <Nop>
" map <Down> <Nop>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OPEN FILES IN DIRECTORY OF CURRENT FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%
map <leader>v :view %%

" make it easy to copy to system clipboard
nmap <leader>cat :! cat  '%:p'<cr>
nmap <leader>pbcopy :! pbcopy <  '%:p'<cr>

" Quick open mappings
nmap <leader>vn :vspl $HOME/Dropbox/notes/vim.notes <cr>
nmap <leader>tn :vspl $HOME/Dropbox/notes/tmux.notes <cr>
nmap <leader>an :vspl $HOME/Dropbox/notes/Alex_Aitken.notes <cr>
nmap <leader>sn :vspl $HOME/Dropbox/notes/shopify.notes <cr>
nmap <leader>nn :vspl $HOME/Dropbox/notes <cr>
nmap <leader>vi :tabedit <C-R>=resolve(expand($MYVIMRC))<cr><cr>

" Close all buffers
nmap <leader>bdd :bufdo bd <cr>
nmap <leader>bee :bufdo e! <cr>

" tab complete buffer changing.
set wildchar=<Tab> wildmenu wildmode=full
set wildcharm=<C-Z>
nnoremap <F10> :b <C-Z>

" Use ag over grep
set grepprg=ag\ --nogroup\ --nocolor

" ag is fast enough that CtrlP doesn't need to cache
let g:ctrlp_use_caching = 0
" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
" bind \ (backward slash) to grep shortcut
command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap \ :Ag<SPACE>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" AutoCommands
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("autocmd")
  " Remove trailing whitespace
  autocmd BufWritePre * :%s/\s\+$//e

  " Source the vimrc file after saving it
  autocmd bufwritepost .vimrc source $MYVIMRC
  autocmd bufwritepost vimrc source $MYVIMRC
  autocmd FileType text setlocal textwidth=78


  " watch for file changes
  autocmd FileChangedShell * echo "File changed :e to reload"
endif

nmap <leader>4 :call ToggleNumberDisplay()<cr>
function! ToggleNumberDisplay()
  if exists('+relativenumber')
    exe "setl" &l:nu ? "rnu" : &l:rnu ? "nornu" : "nu"
  else
    setl nu!
  endif
endfunction
