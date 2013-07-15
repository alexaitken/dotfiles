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
Bundle 'tpope/vim-cucumber'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-markdown'
Bundle 'vim-ruby/vim-ruby'
Bundle 'wincent/Command-T'
Bundle 'altercation/vim-colors-solarized'
Bundle 'thoughtbot/vim-rspec'
Bundle 'leebo/vim-slim'
Bundle 'vim-scripts/tComment'
Bundle 'vim-scripts/greplace.vim'
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "garbas/vim-snipmate"

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

" ESC to <c-c>
map <c-c> <esc>
map! <c-c> <esc>

" spec.vim mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>

" bind control-l to hashrocket
imap <C-l> <Space>=><Space>

" convert string to symbol
nmap <leader>k ds"ds'lbi:<esc>E
imap <leader>k <esc>ds"ds'lbi:<esc>Ea

" CommandT remaps
map <Leader>f :CommandT<CR>
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
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>

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
nmap <leader>vn :50vspl $HOME/Dropbox/notes/vim.notes <cr>
nmap <leader>an :vspl $HOME/Dropbox/notes/Alex_Aitken.notes <cr>
nmap <leader>zn :vspl $HOME/Dropbox/notes/zoocasa.notes <cr>
nmap <leader>nn :vspl $HOME/Dropbox/notes <cr>
nmap <leader>vi :tabedit $MYVIMRC<cr>

" Close all buffers
nmap <leader>bdd :bufdo bd <cr>
nmap <leader>bee :bufdo e! <cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" AutoCommands
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("autocmd")
  " Remove trailing whitespace
  autocmd BufWritePre * :%s/\s\+$//e

  " Source the vimrc file after saving it
  autocmd bufwritepost .vimrc source $MYVIMRC
  autocmd bufwritepost vimrc source $MYVIMRC

  " watch for file changes
  autocmd FileChangedShell * echo "File changed :e to reload"
endif
