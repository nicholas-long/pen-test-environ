# hotkeys
* `ctrl space` : quick menu 
* `ctrl b`     : edit tmux buffer ( nvim )
* `ctrl c`     : copy tmux buffer to host clipboard ( xclip )
* `ctrl y`     : copy host clipboard to tmux buffer ( xclip )
* `ctrl e`     : search for exploits 
* `ctrl z`     : fuzzy find file fzf -> tmux buffer
* `ctrl i`     : find snippets from markdown repositories 
* `ctrl m`     : this help message 
* `ctrl q`     : manage files (copy, move) with fff 
* `ctrl r`     : edit tmux conf
* `r`          : source tmux conf
* `ctrl v`     : fuzzy find file; edit in neovim 
* `ctrl x`     : fuzzy find file on whole machine; edit in neovim 
* `ctrl h`     : movement keys 
* `ctrl j`     : movement keys 
* `ctrl k`     : movement keys 
* `ctrl l`     : movement keys 
* `ctrl .`     : example 

# vim highlighter
`f Enter` set highlight ( word, selection )
`f Backspace` clear highlight ( word, selection )

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
