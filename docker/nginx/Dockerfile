FROM nginx:1.21.3-alpine

COPY docker/nginx/config/vhost.conf /etc/nginx/conf.d/default.conf

WORKDIR /var/www/html

EXPOSE 80
EXPOSE 443
