FROM openresty/openresty:alpine-fat
RUN rm /etc/nginx/conf.d/default.conf
COPY site.conf /etc/nginx/conf.d/
RUN opm get xiangnanscu/pgmoon bungle/lua-resty-prettycjson
COPY site /usr/local/openresty/site