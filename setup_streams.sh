#!/usr/bin/env bash
###################
#
# Created by: Elena Kuznetsov
# Purpose: Setup Streams script
# Version: 0.0.1
# Date: 30/4/2026
# the script is quick fix - not a tool that enables yout to deploy config file
###################
 
echo "Enter the main domain pleaseeee: "
read MAIN_DOMAIN

if [ -f nginx.conf ] && grep -q "$MAIN_DOMAIN" nginx.conf; # we've mentioned this several time: prefer [[ over [ 
then
    echo "Domain $MAIN_DOMAIN already exists!" # 
    exit 1
fi

cat <<EOF > nginx.conf
server {  # good work on using template but this is not upstream of application in webserver
    listen 80;
    server_name $MAIN_DOMAIN;

    resolver 8.8.8.8;

    location / { # you are taking input attaching single sub domain to it and setting it as / (root) while in task you were asked to use several sub domains use them as UPSTEAM.
        set \$target test.$MAIN_DOMAIN;
        proxy_pass http://\$target;
        proxy_set_header Host \$host;
    }
}
EOF 

echo "The $MAIN_DOMAIN was updated, yay!! Restartingggg..."
docker-compose up -d --build
