#!/bin/bash
# 1524_scan.bash scans for hosts with filtered port 1524 and outputs to a file
# port 1524 = metasploitable 2 telnet backdoor

read -p "Enter an IP range: " range
nmap -n -T5 -oG ./scans/1524scan.txt -p 1524 $range/24 &> /dev/null
awk '/1524\/filtered/{print $2}' ./scans/1524scan.txt > temp
mv temp ./scans/1524scan.txt
cat ./scans/1524scan.txt
