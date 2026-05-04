FROM nginx:alpine

RUN rm /etc/nginx/conf.d/default.conf # No point doing this because you're about to override this with mount bind

WORKDIR /etc/nginx/conf.d/

EXPOSE 80 # what about ssl ?

CMD ["nginx", "-g", "daemon off;"]
