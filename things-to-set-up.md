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
- install fzf
- install neovim
- make dir for nvim plugins
- run nvim and install plugins
- add to bashrc
  - functions.sh
  - variables.sh
- git clone http://github.com/nicholas-long/kb
- git
  - enable credential storage ( command in kb )
  - configure github username and email
    - git config --global user.name "Nicholas Long"
    - git config --global user.email "nicholas.eden.long@gmail.com"
  - log in to github by cloning out a private repository 
- add the following crontab
```crontab
*/5 * * * * /bin/bash -c "DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus /usr/bin/notify-send -i appointment-soon -c 'im' 'stop running down rabbit holes'"
```

# New machine setup
- bookmarks bar
  - https://gchq.github.io/CyberChef/
  - https://book.hacktricks.xyz/
- install & configure docker to not eat the whole hard drive (with logs)
