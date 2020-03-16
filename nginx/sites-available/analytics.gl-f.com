server {
    listen 80;
    server_name analytics.gl-f.com;
    return 301 https://$host$request_uri;
}
server {
    server_name analytics.gl-f.com;
        listen 443 ssl http2;
        listen [::]:443 ssl http2;

        ssl_certificate /etc/nginx/cert/glf/STAR_gl-f_com.crt;
        ssl_certificate_key /etc/nginx/cert/glf/STAR_gl-f_com.key;

#        ssl_session_cache shared:SSL:20m;
#        ssl_session_timeout 60m;
#        ssl_prefer_server_ciphers on;
#        ssl_ciphers ECDH+AESGCM:ECDH+AES256:ECDH+AES128:DHE+AES128:!ADH:!AECDH:!MD5;
#        ssl_dhparam /etc/nginx/cert/dhparam.pem;
#        ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
#        ssl_stapling on;
#        ssl_stapling_verify on;
#        ssl_trusted_certificate /etc/nginx/cert/glf/STAR_gl-f_com.crt;
#        resolver 8.8.8.8 8.8.4.4;
        #add_header Strict-Transport-Security "max-age=31536000; includeSubDomains" always;
#        add_header Strict-Transport-Security "max-age=31536000" always;
        location / {
               proxy_set_header Host $http_host;
               proxy_set_header X-Real-IP $remote_addr;
               proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
               proxy_set_header X-Forwarded-Proto $scheme;
	       #proxy_redirect https://analytics.gl-f.com/ https://analytics.gl-f.com/customlogin/4/;
               proxy_pass https://172.255.152.60/;

                 }
}
