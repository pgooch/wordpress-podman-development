# Pull wordpress as a starting point
FROM wordpress:latest

# Install additional software
RUN apt-get update
RUN apt-get install -y openssl

# Enable Apache modules
RUN a2enmod ssl rewrite

# Setup Apache SSL and gen a cert
RUN mkdir -p /etc/apache2/ssl
RUN openssl req -x509 -nodes -days 365 \
  -newkey rsa:2048 \
  -keyout /etc/apache2/ssl/apache.key \
  -out /etc/apache2/ssl/apache.crt \
  -subj "/C=US/ST=Local/L=Local/O=Local/OU=Development/CN=localhost"

# Expose both HTTP and HTTPS ports
EXPOSE 80 443
