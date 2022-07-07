FROM nginx:alpine

ENV NGINX_HTML_DIR /usr/share/nginx/html

COPY --from=origin /app/dist $NGINX_HTML_DIR

# TODO

# COPY docker-entrypoint.sh /
# ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["nginx", "-g", "daemon off;"]
