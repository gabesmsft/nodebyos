#!/usr/bin/env bash

# Get environment variables to show up in SSH session
eval $(printenv | sed -n "s/^\([^=]\+\)=\(.*\)$/export \1=\2/p" | sed 's/"/\\\"/g' | sed '/=/s//="/' | sed 's/$/"/' >> /etc/profile)

echo "Setup openrc ..." && openrc && touch /run/openrc/softlevel

# Add SSH_PORT to config

echo Updating /etc/ssh/sshd_config to use PORT $SSH_PORT
sed -i "s/SSH_PORT/$SSH_PORT/g" /etc/ssh/sshd_config

# Start SSH
echo Starting ssh service...
rc-service sshd start

# We want all ssh sesions to start in the /home directory
echo "cd /home" >> /etc/profile

npm start
