FROM openresty/openresty:alpine-fat
COPY site /usr/local/openresty/site
RUN rm /etc/nginx/conf.d/default.conf
COPY site.conf /etc/nginx/conf.d/
RUN opm get xiangnanscu/pgmoon