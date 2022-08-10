# hotkeys
* `ctrl space`           : default prefix key
* Prefix + `ctrl space`  : quick menu 
* Prefix + `ctrl a`      : fuzzy find and install apt packages
* Prefix + `ctrl b`      : edit tmux buffer ( nvim )
* Prefix + `ctrl c`      : copy tmux buffer to host clipboard ( xclip )
* Prefix + `ctrl y`      : copy host clipboard to tmux buffer ( xclip )
* Prefix + `ctrl e`      : search for exploits 
* Prefix + `ctrl z`      : fuzzy find file fzf -> tmux buffer
* Prefix + `ctrl i`      : Reverse shell IP menu
* Prefix + `ctrl o`      : find snippets from markdown repositories 
* Prefix + `ctrl m`      : this help message 
* Prefix + `ctrl q`      : manage files (copy, move) with fff 
* Prefix + `ctrl r`      : edit tmux conf
* Prefix + `r`           : source tmux conf
* Prefix + `ctrl v`      : fuzzy find file; edit in neovim 
* Prefix + `ctrl x`      : fuzzy find file on whole machine; edit in neovim 
* `ctrl h,j,k,l`         : movement keys

# vim highlighter
`f Enter` set highlight ( word, selection )
`f Backspace` clear highlight ( word, selection )
`nmap <Space>hl :Hi:load<CR>` load highlights
`nmap <Space>hs :Hi:save<CR>` save highlights
`nmap <Space>h= :Hi ==<CR>` sync highlights across panes

# aliases
`k` : fuzzy search snippets; `kc` : copy
`exploits` : fuzzy search searchsploit
`vars` : edit `~/variables.sh`
`boxnotes` `startnotes` : init/start notes
`tl` : fuzzy search tldr
`ht` : fuzzy search hacktricks
`gtfo` : fuzzy search gtfobins
`payl` : fuzzy search `~/PayloadsAllTheThings`
`a`: fuzzy search apt packages,install
`c`: fuzzy cd

# [M] fff hotkeys
```
j: scroll down
k: scroll up
h: go to parent dir
l: go to child dir

enter: go to child dir
backspace: go to parent dir

-: Go to previous dir.

g: go to top
G: go to bottom

:: go to a directory by typing.

.: toggle hidden files
/: search
t: go to trash
~: go to home
e: refresh current dir
!: open shell in current dir

x: view file/dir attributes
i: display image with w3m-img

down:  scroll down
up:    scroll up
left:  go to parent dir
right: go to child dir

f: new file
n: new dir
r: rename
X: toggle executable

y: mark copy
m: mark move
d: mark trash (~/.local/share/fff/trash/)
s: mark symbolic link
b: mark bulk rename

Y: mark all for copy
M: mark all for move
D: mark all for trash (~/.local/share/fff/trash/)
S: mark all for symbolic link
B: mark all for bulk rename

p: execute paste/move/delete/bulk_rename
c: clear file selections

[1-9]: favourites/bookmarks (see customization)

q: exit with 'cd' (if enabled).
Ctrl+C: exit without 'cd'.
```
