FROM nginx:alpine

RUN apk update \
 && apk add \
    ca-certificates \
    wget

ADD certs /etc/ssl

RUN rm -f /etc/nginx/conf.d/default.conf
ADD conf/default.conf /etc/nginx/conf.d/default.conf
ADD conf/nginx.conf /etc/nginx/nginx.conf
