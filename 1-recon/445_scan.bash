#!/bin/bash
# 445_scan.bash scans for port 445 and outputs to a file [445_scan.txt]
#       nmap grep-able output
# awk is used to parse for hosts with the open port and output to a file
# The IP addresses are then moved to the rc folder and will be used to generate a metasploit resource script to execute the ms08_067_netapi metasploit module on multiple hosts
# port 445 = smb

read -p "Enter an IP range: " range
nmap -n -T5 -oG ./scans/445_scan.txt -p 445 $range/24 &> /dev/null
awk '/445\/open/{print $2}' ./scans/445_scan.txt > temp
mv temp ./scans/445_scan.txt
cat ./scans/445_scan.txt
cp ./scans/445_scan.txt ../2-generate/hosts/
