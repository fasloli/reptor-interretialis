#!/usr/bin/env bash
###################
#
# Created by: Elena Kuznetsov
# Purpose: Setup Streams script
# Version: 0.0.1
# Date: 30/4/2026
#
###################

echo "Enter the main domain pleaseeee: "
read MAIN_DOMAIN

if [ -f nginx.conf ] && grep -q "$MAIN_DOMAIN" nginx.conf;
then
    echo "Domain $MAIN_DOMAIN already exists!"
    exit 1
fi

cat <<EOF > nginx.conf
server {
    listen 80;
    server_name $MAIN_DOMAIN;

    resolver 8.8.8.8;

    location / {
        set \$target test.$MAIN_DOMAIN;
        proxy_pass http://\$target;
        proxy_set_header Host \$host;
    }
}
EOF

echo "The $MAIN_DOMAIN was updated, yay!! Restartingggg..."
docker-compose up -d --build
