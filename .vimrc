set nocompatible

source ~/.vim/bundles.vim
source ~/.vim/ui.vim

" map leader to comma
let mapleader="\\"

" CTags
map <Leader>T :!ctags --extra=+f -R *<CR><CR>
set tags=tmp/tags;/,./tmp/tags;/,tags;/,./tags;/

" This is an alternative that also works in block mode, but the deleted text
" is lost and it only works for putting the current register.
"vnoremap p "_dp

"<Leader>v brings up my .vimrc
map <Leader>v :sp $DOTFILES/vimrc<CR>

" automatically source vimrc if writing .vimrc or vimrc
autocmd! BufWritePost .vimrc,vimrc source $MYVIMRC

" <Leader>w clears end of line whitespace
map <Leader>w :%s/\s\+$//g<CR>

" <Leader>s converts beginning of line tabs to spaces
map <Leader>s :retab<CR>

" <Leader>h runs noh
map <Leader>h :noh<CR>

" <Leader>f sets the text width to 80 and then reformats the current document
map <Leader>f :setl tw=80<CR>gggqG<CR>

" Key sequence mappings
" execute current line as shell command, and open output in new window
map <Leader>x :silent . w ! sh > ~/.vim_cmd.out<CR>:new ~/.vim_cmd.out<CR>

" suppress netrw history file from being saved
let g:netrw_dirhistmax=0

" enable filetype plugins
filetype plugin on
