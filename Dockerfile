# Use a base image with Nginx
FROM nginx:alpine

# Install necessary packages for Authelia
RUN apk --no-cache add ca-certificates su-exec

# Copy the Nginx configuration file to the container
COPY nginx.conf /etc/nginx/nginx.conf.template

# Copy Authelia configuration to the container
COPY configuration.yml /authelia/configuration.yml.template

# Set up the entry point to start Nginx and Authelia
CMD ["sh", "-c", "envsubst < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf && envsubst < /authelia/configuration.yml.template > /authelia/configuration.yml && nginx -g 'daemon off;' & authelia --config /authelia/configuration.yml"]
