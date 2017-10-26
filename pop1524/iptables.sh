#!/bin/bash
# Basic iptables script to allow ping, ingress, and egress

iptables -F

iptables -A INPUT -i lo -s 127.0.0.1 -j ACCEPT
iptables -A OUTPUT -o lo -s 127.0.0.1 -j ACCEPT

iptables -A INPUT -p tcp -m multiport --dports 20,21,22 -j ACCEPT
iptables -A OUTPUT -p tcp -m multiport --sports 20,21,22 -j ACCEPT

iptables -A OUTPUT -p tcp -m multiport --dports 20,21,22 -j ACCEPT
iptables -A INPUT -p tcp -m multiport --sports 20,21,22 -j ACCEPT

iptables -A INPUT -p ICMP --icmp-type 0 -j ACCEPT
iptables -A OUTPUT -p ICMP --icmp-type 0 -j ACCEPT
iptables -A INPUT -p ICMP --icmp-type 8 -j ACCEPT
iptables -A OUTPUT -p ICMP --icmp-type 8 -j ACCEPT

iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT DROP
