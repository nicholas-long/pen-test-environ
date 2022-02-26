# On a normal kali install
Fix these items after installing environment
- set up terminal
  - install alacritty if you want - instructions on kb https://github.com/nicholas-long/kb/blob/main/linux/install-alacritty.md
  - fix qterminal preferences to if you want to use qterminal
    - set emulation mode to linux
- set key repeat speed
  - range 200 ( minimum ) - 500 ( too slow )
- set up zsh
  - install oh-my-zsh 
    - this changes ~/.zshrc
  - add some kali default zsh stuff back in
    - `cat ~/tmux-scripts/kali-stuff-to-add-to-zsh.rc >> ~/.zshrc`
  - add `source ~/variables.sh` if you want to define env vars like `$IP` in every term
- set up `~/tmux-scripts/kb_locations.lst` if your username is not coyote 

# New machine setup
- bookmarks bar
  - https://gchq.github.io/CyberChef/
  - https://book.hacktricks.xyz/
- install & configure docker to not eat the whole hard drive (with logs)