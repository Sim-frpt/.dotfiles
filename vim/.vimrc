
" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2017 Sep 20
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  " Let's save undo info!
  if !isdirectory($HOME."/.vim")
    call mkdir($HOME."/.vim", "", 0770)
  endif
  if !isdirectory($HOME."/.vim/undo-dir")
    call mkdir($HOME."/.vim/undo-dir", "", 0700)
  endif
  set undodir=~/.vim/undo-dir
  set undofile
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif

" set encoding
set encoding=utf8

" set Leader
let g:mapleader=","

" prevent .netrwhist file from being created
let g:netrw_dirhistmax=0

" Change viminfo location
set viminfo+=n~/.vim/viminfo

" Set colorscheme
colorscheme gruvbox
set background=dark

" Set line numbers and relative line numbers
:set number relativenumber

" Make it so relative numbers are the default when in normal mode, and
" 'normal' numbers in insert mode or when the buffer loses focus
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END

" Set incsearch
set incsearch

" Use <esc> to clear the highlighting of :set hlsearch.
:nnoremap <esc> :noh<return><esc>

" change highlight search color
hi Search cterm=NONE ctermfg=Black ctermbg=DarkMagenta
hi IncSearch cterm=underline,bold ctermfg=White ctermbg=DarkMagenta

" Set scrolloff, sidescrolloff and display as much as possible of the last
" line of the window
if !&scrolloff
  set scrolloff=1
endif
if !&sidescrolloff
  set sidescrolloff=5
endif
set display+=lastline

" Set backup dir in vimtmp
set backupdir=~/.vim/vimtmp//,.
set directory=~/.vim/vimtmp//,.

" Set path for plugins
set runtimepath^=~/.vim/bundle/

" Set Pathogen plugin manager
execute pathogen#infect()

" Set Lightline plugin
set laststatus=2
let g:lightline = {
    \ 'colorscheme': 'seoul256',
    \ }

" remap j and k so that they don't skip a single line visually represented as
" several
nnoremap j gj
nnoremap k gk

" set tabstop and shiftwidth to 2 and enable expandtab
set ts=2 sw=2 et

" set indent guide for tabs
:set list lcs=tab:\|\

" set indentLine plugin
let g:indentLine_char = '|'

" Add Tmux Color Compatibility
set term=screen-256color

" Autocompletion
filetype plugin on
set omnifunc=syntaxcomplete#Complete

" Autoclosing brackets
inoremap { {}<left>

" Remap <C-w>
:nnoremap <Leader>w <C-w>

" Remap NERDTree autofocus
nmap <Leader>t :NERDTreeToggle<CR>

" Remove annoying *BEEEP*
set visualbell

" Set line wrapping
set wrap
set linebreak

" Prevent vim from inserting line breaks in newly entered text
set textwidth=0
set wrapmargin=0

" Indents word-wrapped lines as much as the 'parent' line
set breakindent

" add mapping to move tabs left and right using Alt + direction
noremap <Leader>h  :tabmove -1<CR>
noremap <Leader>l :tabmove +1<CR>

" add shortcut to move to last active tab quickly
if !exists( "g:lasttab" )
  let g:lasttab = 1
endif
nmap <Leader>lt :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" Add vimrc_coc config
source ~/.vimrc_coc_config

" Remove trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e

" NERDTrees File highlighting (for vim-devicons)
" conceallevel removes brackets around icons (normally at 2)
set conceallevel=3

function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
  exec 'autocmd FileType nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
  exec 'autocmd FileType nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')
call NERDTreeHighlightFile('ds_store', 'Gray', 'none', '#686868', '#151515')
call NERDTreeHighlightFile('gitconfig', 'Gray', 'none', '#686868', '#151515')
call NERDTreeHighlightFile('gitignore', 'Gray', 'none', '#686868', '#151515')
call NERDTreeHighlightFile('bashrc', 'Gray', 'none', '#686868', '#151515')
call NERDTreeHighlightFile('bashprofile', 'Gray', 'none', '#686868', '#151515')
