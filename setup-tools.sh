#!/bin/bash

#prep wordlists
sudo gunzip /usr/share/wordlists/rockyou.txt.gz
sudo apt install -y seclists

#upload and enumeration scripts
cd /opt
sudo git clone https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite.git
sudo git clone https://github.com/rebootuser/LinEnum.git
sudo git clone https://github.com/pentestmonkey/php-reverse-shell.git
sudo git clone https://github.com/itm4n/PrivescCheck.git
sudo mkdir pspy
cd pspy
sudo wget https://github.com/DominicBreuker/pspy/releases/download/v1.2.0/pspy32
sudo wget https://github.com/DominicBreuker/pspy/releases/download/v1.2.0/pspy64
sudo wget https://github.com/DominicBreuker/pspy/releases/download/v1.2.0/pspy32s
sudo wget https://github.com/DominicBreuker/pspy/releases/download/v1.2.0/pspy64s
cd ~/

#install necessary tools
sudo apt install -y python3-pip

#install useful tools that should be here
sudo apt install -y gobuster 
sudo apt install -y ffuf
#need this for some CTFs that hide stuff in images
sudo apt install -y steghide
sudo apt install -y libimage-exiftool-perl
sudo gem install seccomp-tools
#install gef for gdb
bash -c "$(curl -fsSL http://gef.blah.cat/sh)"
sudo pip3 install pwntools
