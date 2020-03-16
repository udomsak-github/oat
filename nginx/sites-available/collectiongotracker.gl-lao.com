server {
 #   if ($host = collectiongotracker.gl-lao.com) {
 #       return 301 https://$host$request_uri;
 #   } # managed by Certbot


    listen 80;
    server_name collectiongotracker.gl-lao.com;
#    return 301 https://$host$request_uri;
location / {
proxy_set_header Host $http_host;
               proxy_set_header X-Real-IP $remote_addr;
               proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
               proxy_set_header X-Forwarded-Proto $scheme;
proxy_pass http://172.255.152.146/;
}

}
server {
    server_name collectiongotracker.gl-lao.com;
        listen 443 ssl http2;
#        listen [::]:443 ssl http2;
    ssl_certificate /etc/letsencrypt/live/collectiongotracker.gl-lao.com/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/collectiongotracker.gl-lao.com/privkey.pem; # managed by Certbot

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
        add_header Strict-Transport-Security "max-age=31536000" always;
        location / {
               proxy_set_header Host $http_host;
               proxy_set_header X-Real-IP $remote_addr;
               proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
               proxy_set_header X-Forwarded-Proto $scheme;
 if ($request_method = 'OPTIONS') {

        add_header 'Access-Control-Allow-Origin' '*';
        
        #
        # Om nom nom cookies
        #

        add_header 'Access-Control-Allow-Credentials' 'true';
        add_header 'Access-Control-Allow-Methods' 'GET, POST, OPTIONS';
        
        #
        # Custom headers and headers various browsers *should* be OK with but aren't
        #

        add_header 'Access-Control-Allow-Headers' 'DNT,X-Mx-ReqToken,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type';
        
        #
        # Tell client that this pre-flight info is valid for 20 days
        #

        add_header 'Access-Control-Max-Age' 1728000;
        add_header 'Content-Type' 'text/plain charset=UTF-8';
        add_header 'Content-Length' 0;

        return 204;
     }

     if ($request_method = 'POST') {

        add_header 'Access-Control-Allow-Origin' '*';
        add_header 'Access-Control-Allow-Credentials' 'true';
        add_header 'Access-Control-Allow-Methods' 'GET, POST, OPTIONS';
        add_header 'Access-Control-Allow-Headers' 'DNT,X-Mx-ReqToken,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type';

     }

     if ($request_method = 'GET') {

        add_header 'Access-Control-Allow-Origin' '*';
        add_header 'Access-Control-Allow-Credentials' 'true';
        add_header 'Access-Control-Allow-Methods' 'GET, POST, OPTIONS';
        add_header 'Access-Control-Allow-Headers' 'DNT,X-Mx-ReqToken,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type';

     }
	       #proxy_redirect https://analytics.gl-f.com/ https://analytics.gl-f.com/customlogin/4/;
               proxy_pass http://172.255.152.146/;

                 }


}
