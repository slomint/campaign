#!/bin/bash
# 22_scan.bash scans for port 22 and outputs to a file
#       nmap grep-able output
# awk is used to parse the output for hosts with the open port and output to a file
# The IP addresses are then moved to the rc folder and will be used to generate a metasploit resource script for SSH brute force using the metasploit auxiliary ssh_login module
# port 22 = SSH

read -p "Enter an IP range: " range
nmap -n -T5 -oG ./scans/22_scan.txt -p 22 $range/24 &> /dev/null
awk '/22\/open/{print $2}' ./scans/22_scan.txt > temp
mv temp ./scans/22_scan.txt
cat ./scans/22_scan.txt
cp ./scans/22_scan.txt ../2-generate/hosts/
