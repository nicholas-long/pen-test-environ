set expandtab
set tabstop=2
set shiftwidth=2
set number
set relativenumber
set noerrorbells
set nocompatible              " be iMproved, required
filetype off                  " required

set path=.,,**
set mouse=a

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-surround'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
"Plugin 'valloric/youcompleteme' " requires vim with python support
"Plugin 'christoomey/vim-tmux-navigator'
Plugin 'airblade/vim-gitgutter'
Plugin 'bling/vim-airline'
Plugin 'altercation/vim-colors-solarized'
Plugin 'morhetz/gruvbox'
Plugin 'scrooloose/nerdtree'
Plugin 'azabiong/vim-highlighter'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
syntax enable

set list listchars=tab:▸\ ,eol:¬,trail:·
set list
let g:solarized_termcolors=256
set background=dark
"colorscheme solarized
colorscheme gruvbox

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" hacks
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" example macros
" let @q="yyp"

set number
set relativenumber
set noerrorbells
set nowrap

" source the file
nmap <Space>gs :source ~/.config/nvim/init.vim <Enter>

" terminal normal mode escape for neovim
tmap <Esc> <C-\><C-N>

" movement in terminal
tmap <C-w>j <Esc><C-w>j
tmap <C-w>k <Esc><C-w>k
tmap <C-w>l <Esc><C-w>l
tmap <C-w>h <Esc><C-w>h

" exit insert mode with jk
imap jk <Esc>

" ctrl w p to paste in terminal
tmap <C-w>p <C-\><C-N>pi

" exit terminal
tmap <C-w><C-q> <C-\><C-N>:q!<Enter>

" quit window
nmap <C-w><C-q> <C-\><C-N>:q!<Enter>

" leave terminal mode and go to normal mode
tmap ;; <Esc>

" split windows
nmap <Space>g :vert split<Enter>

" trying out v and s for split keys
"nmap <Space>v :split<Enter>
nmap <Space>s :split<Enter>

" move easy
nmap <Space>j <C-w>j
nmap <Space>k <C-w>k
nmap <Space>l <C-w>l
nmap <Space>h <C-w>h

" split terminal from normal mode
nmap <Space>t :split<Enter> :term<Enter>i
nmap <Space>tg :vert split<Enter> :term<Enter>i

" split new terminals
tmap <C-w><Space>t <C-\><C-N>:split<Enter> :term<Enter>i
tmap <C-w><Space>g <C-\><C-N>:vert split<Enter> :term<Enter>i

"tmap <C-w><Space>e <C-\><C-N>:vert split<Enter> :term<Enter>i
"tmap <Space>tg :vert term<Enter>
"tmap <Space>tt :term<Enter>

" edit the current terminal line 
"nmap <C-w><Space>e yy:term <Enter>
tmap <C-w>e <C-\><C-N>yy:split<Enter><C-w>j:e cmdscratch<Enter>p

" This is the default option:
"   - Preview window on the right with 50% width
"   - CTRL-/ will toggle preview window.
" - Note that this array is passed as arguments to fzf#vim#with_preview function.
" - To learn more about preview window options, see `--preview-window` section of `man fzf`.
let g:fzf_preview_window = ['right:50%', 'ctrl-/']

nmap <Space>f :Files<Enter>

" paste tmux buffer
nmap <Space>p :r! tmux saveb -<Enter>

" copy to tmux buffer
vmap <Space>c :w! /tmp/tmuxbuf <Enter>:r! tmux loadb /tmp/tmuxbuf<Enter>

" look up highlighted thing in searchsploit and paste down
vmap <Space>l y:r! ~/tmux-scripts/searchsploit-plain-text.sh <C-r>"<Enter>

" space q to quit gently, C-w C-q to force
nmap <Space>q :q<Enter>
nmap <C-s> :w<Enter>

" space w to write
nmap <Space>w :w<Enter>

" abbreviations
abbr _sh #!/bin/bash
abbr _awk awk '{print $1}'
abbr _dn /dev/null

nmap <Space>kb :r ~/kb/

" add comma from normal mode
nmap <Space>, Ea,<Esc>
" surround rest of line "with quotes or parens"
nmap <Space>` ebi`<Esc>A`<Esc>
nmap <Space>" ebi"<Esc>A"<Esc>
nmap <Space>' ebi'<Esc>A'<Esc>
nmap <Space>( ebi(<Esc>A)<Esc>%
nmap <Space>< ebi<<Esc>ea><Esc>

" spacing lines
nmap <Space><Space>j o<Esc>
nmap <Space><Space>k O<Esc>

" trim last char
nmap <Space><Space>x mz$x`z
"
" quit all
nmap <C-q> :qa!

" enter for command
nmap <C-m> :set norelativenumber<C-m>:

" reset relative numbers when you are done doing ex stuff
nmap <Space><Space>r :set relativenumber<C-m>

" make titles
nmap <Space>- yypv$r-o<Esc>
nmap <Space>= yypv$r=o<Esc>
nmap - i-<Esc>xo<Esc>100p

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" stack workflow
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" stack operations
" tab to push line
nmap <Tab> :ka<Enter>:y<Enter>:0 put<Enter>:'a<Enter>
" tab to push selected in visual
vmap <Tab> yma:0 put<Enter>`a
" dup
nmap <Space>d yyp

" data section (appended to end of file)
" quick execute line as bash cmd and append output text
nmap <Space>$ :y<Enter>:$pu<Enter>:$!bash<Enter>k-0j
" read
nmap <Space># :y<Enter>:$r <C-r>"
nmap gr :y<Enter>:$r <C-r>"
" store
nmap gw :0,.m$<Enter>gg
vmap gw :m$<Enter>gg

" move ops
" move current line to top
nmap <Space>a :m0<Enter>
" move visual selected lines to top
vmap <Space>a :'<'>m0<Enter>

" extract data
" extract highlighted text upwards
vmap <Space>k mayO<C-r>"<Esc>`a
" extract rest of line
nmap <Space>e DuO<C-r>"<Esc>
" extract beginning of line
nmap ge d0O<C-r>"<Esc>
" filter
nmap <Space>gf :,$g/
nmap <Space>/ :,$g/

" line quick operations
" cut line
nmap gk Do<C-r>"<Esc>
" split on commas
nmap g, :s/,/,\r/g<Enter>
" insert a space up
nmap <Space><Space><Space> O<Esc>
" join lines
nmap <Space>gj :0,.j<Enter>
nmap <Space>gJ :0,.j!<Enter>
nmap gj :0,.j<Enter>
nmap gJ :0,.j!<Enter>

" search and open files
" look up files containing this line
nmap <Space>i 0y$:NERDTree<Enter>/<C-r>"<Enter><Enter>:NERDTreeToggle<Enter>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" tabulate data for awk
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nmap <Space><BS> :s/\s\+/ /<Enter>
vmap <Space><BS> :s/\s\+/ /<Enter>
nmap <Space><Tab> :s/ \+/\t/<Enter>/\t<Enter>
vmap <Space><Tab> :s/ \+/\t/<Enter>/\t<Enter>
nmap <Space><Tab><Tab> :s/ \+/\t/g<Enter>/\t<Enter>
vmap <Space><Tab><Tab> :s/ \+/\t/g<Enter>/\t<Enter>
