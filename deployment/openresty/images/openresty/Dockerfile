FROM openresty/openresty:alpine-fat

RUN apk add inotify-tools

# RUN opm get leafo/pgmoon

RUN luarocks install pgmoon 1.6.0 && \
  luarocks install inspect && \
  luarocks install middleclass && \
  luarocks install uuid && \
  luarocks install date && \
  luarocks install csv && \
  luarocks install LuaFileSystem && \
  luarocks install graphql

RUN rm /etc/nginx/conf.d/default.conf

COPY docker-entrypoint.sh /usr/local/openresty/bin
COPY reloader.sh /usr/local/openresty/bin

COPY site.conf /etc/nginx/conf.d/
COPY site /usr/local/openresty/site

ENTRYPOINT [ "/usr/local/openresty/bin/docker-entrypoint.sh" ]
CMD [ "/usr/local/openresty/bin/openresty", "-g", "daemon off;" ]