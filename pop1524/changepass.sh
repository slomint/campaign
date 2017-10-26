#!/bin/bash
# changepass.sh will change the password of all users with shell /bin/bash

for i in `grep /bin/bash /etc/passwd | awk -F":" '{print $1}'`; do
    echo -e "password\npassword" | passwd $i
done
