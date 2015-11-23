#!/bin/bash

# Change root password after each start
ROOT_PASSWORD=$(pwgen -s 12 1)

echo "root:$ROOT_PASSWORD" | chpasswd

echo "========================================================================"
echo "You can now connect with the root password : "
echo ""
echo "    $ROOT_PASSWORD"
echo ""
echo "========================================================================"
echo "$ROOT_PASSWORD" > /credentials
chmod 600 /credentials

# Add a user
if id -u "sshguest" >/dev/null 2>&1; then
	echo sshguest:$ROOT_PASSWORD | chpasswd
else
	useradd -m -s /bin/bash --home-dir=/home/sshguest --user-group sshguest; echo sshguest:$ROOT_PASSWORD | chpasswd
fi

exec /usr/sbin/sshd -D