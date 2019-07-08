#!/bin/bash
tee -a /etc/nginx/sites-enabled/bashy.conf << EOF
server {
    listen 3200 default_server;

    server_name nonbenign.com www.nonbenign.com;

    location / {
        proxy_pass http://127.0.0.1:8080/;
    }
}
EOF

