FROM php:8.1.9-fpm-alpine

WORKDIR /var/www/html/

# Essentials
RUN echo "UTC" > /etc/timezone && apk add --no-cache nginx supervisor

# PHP extensions
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copy code
COPY . .

# Setup log file & owner
RUN touch /var/www/html/storage/logs/laravel.log && chown -R www-data:www-data /var/www/html/storage


COPY docker/supervisord.ini /etc/supervisor.d/supervisord.ini
COPY docker/php.ini /usr/local/etc/php/conf.d/app.ini
COPY docker/run.sh /var/www/run.sh
COPY docker/nginx.conf /etc/nginx/
COPY docker/laravel-site.conf /etc/nginx/http.d/default.conf

# PHP Error Log Files
RUN mkdir /var/log/php
RUN touch /var/log/php/errors.log && chmod +rw /var/log/php/errors.log


# Deployment steps
RUN composer update --optimize-autoloader --no-dev
RUN chmod +x /var/www/run.sh

EXPOSE 80
ENTRYPOINT ["/var/www/run.sh"]