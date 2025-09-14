# Use the official PHP Apache image
FROM php:8.3-apache

# Install system dependencies and PHP extensions required by Laravel
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libpq-dev \
    libzip-dev \
    zip \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    && docker-php-ext-install pdo pdo_pgsql zip gd mbstring exif pcntl bcmath

# Enable Apache mod_rewrite for Laravel's routing
RUN a2enmod rewrite

# Set the working directory
WORKDIR /var/www/html

# Copy Composer from the official Composer image
COPY --from=composer:2.6 /usr/bin/composer /usr/bin/composer

# Copy the Laravel project files into the container
COPY . .

# Install PHP dependencies without running post-install scripts
# This avoids failures due to missing environment variables during build
RUN composer install

# Set proper permissions for Laravel storage and cache folders
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Set Apache Document Root to the Laravel public folder
ENV APACHE_DOCUMENT_ROOT=/var/www/html/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# Expose port 80 to the outside world
EXPOSE 80

# Start Apache
# CMD php artisan migrate:fresh --force && php artisan db:seed && php artisan passport:install && apache2-foreground
CMD php artisan migrate --force && \
    chown -R www-data:www-data storage bootstrap/cache && \
    chmod -R 775 storage bootstrap/cache && \
    apache2-foreground
