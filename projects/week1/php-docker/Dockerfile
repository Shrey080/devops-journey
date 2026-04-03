# Stage 1: Build
FROM php:8.0-apache AS builder
WORKDIR /var/www/html
COPY . .
RUN apt-get update && apt-get install -y zip unzip

# Stage 2: Production
FROM php:8.0-apache AS production
WORKDIR /var/www/html
COPY --from=builder /var/www/html .
RUN chown -R www-data:www-data /var/www/html
EXPOSE 80
