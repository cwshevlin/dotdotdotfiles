" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

call pathogen#infect()

syntax on

if has("autocmd")
  filetype plugin indent on
endif

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Store temporary files in a central spot
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set nobackup                          " do not keep a backup file
set nowritebackup                     " do not write a backup file

set complete=.,b,u,]

set history=50                        " keep 50 lines of command line history
set ruler                             " show the cursor position all the time
set showcmd                           " display incomplete commands
set incsearch                         " do incremental searching
set vb                                " turn on visual bell
set nu                                " show line numbers
set sw=2                              " set shiftwidth to 2
set ts=2                              " set number of spaces for a tab to 2
set et                                " expand tabs to spaces
set ignorecase                        " ignorecase in searches
set hlsearch                          " highlight patterns when searching
set nohidden                          " remove buffer when a tab is closed

" CTags
map <Leader>T :!ctags --extra=+f -R *<CR><CR>
set tags=tmp/tags;/,./tmp/tags;/,tags;/,./tags;/

" Don't use Ex mode, use Q for formatting
map Q gq

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  " autocmd FileType text setlocal textwidth=78

  " For all ruby files, set 'shiftwidth' and 'tabspace' to 2 and expand tabs to spaces.
  autocmd FileType ruby,eruby set sw=2 ts=2 et
  autocmd FileType python set sw=4 ts=4 et

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Save on focus lost
  " :au FocusLost * :wa

  augroup END

else

  set autoindent    " always set autoindenting on

endif " has("autocmd")

" Easily open and reload vimrc
"<Leader>v brings up my .vimrc
"<Leader>V reloads it -- making all changes active (have to save first)
map <Leader>v :sp $DOTFILES/vimrc<CR>

" automatically source vimrc if writing .vimrc or vimrc
autocmd! BufWritePost .vimrc,vimrc source $MYVIMRC

" <Leader>w clears end of line whitespace
map <Leader>w :%s/\s\+$//g<CR>

" Key sequence mappings
" In command-mode, typing %/ will replace those chars with the directory of
" the file in the current buffer
cmap %/ <C-r>=expand('%:p:h')<CR>/
" execute current line as shell command, and open output in new window
map <Leader>x :silent . w ! sh > ~/.vim_cmd.out<CR>:new ~/.vim_cmd.out<CR>

" Character mapping
cnoremap <C-a> <Home>
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <Esc>b <S-Left>
cnoremap <Esc>f <S-Right>

" Sessions ********************************************************************
set sessionoptions=blank,buffers,curdir,folds,help,options,resize,tabpages,winpos,winsize,globals

function! AutosaveSessionOn(session_file_path)
  augroup AutosaveSession
    au!
    exec "au VimLeave * mks! " . a:session_file_path
  augroup end
  let g:AutosaveSessionFilePath = a:session_file_path

  echo "Auto-saving sessions to \"" . a:session_file_path . "\""
endfunction
function! AutosaveSessionOff()
  if exists("g:AutosaveSessionFilePath")
    unlet g:AutosaveSessionFilePath
  endif

  augroup AutosaveSession
    au!
  augroup end
  augroup! AutosaveSession

  echo "Auto-saving sessions is off"
endfunction
command! -complete=file -nargs=1 AutosaveSessionOn call AutosaveSessionOn(<f-args>)
command! AutosaveSessionOff call AutosaveSessionOff()
augroup AutosaveSession
  au!
  au SessionLoadPost * if exists("g:AutosaveSessionFilePath") != 0|call AutosaveSessionOn(g:AutosaveSessionFilePath)|endif
augroup end

" White space ****************************************************************
let hiExtraWhiteSpace = "hi ExtraWhitespace ctermbg=red guibg=red"
exec hiExtraWhiteSpace
au ColorScheme * exec hiExtraWhiteSpace
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au BufRead,InsertLeave * match ExtraWhitespace /\s\+$/
set list
set listchars=tab:▸\ ,eol:¬

" Colors *********************************************************************
if has("gui_running")
  " sweet color scheme using true color
  syntax enable
  set background=light
  colorscheme molokai
else
  set background=light
end

" FuzzyFinder ******************************************************************
" noremap <C-t> :FufCoverageFile<CR>

" Ctrl-P
noremap <C-t> :CtrlPMixed<CR>

" Command-T ******************************************************************
" noremap <C-t> :CommandT<CR>
" let g:CommandTMaxFiles=80085
"
" OS X clipboard when yanking/pasting
set clipboard=unnamed
