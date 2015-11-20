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

exec supervisord -n