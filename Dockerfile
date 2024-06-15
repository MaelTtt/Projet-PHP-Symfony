# Use an official PHP runtime as a parent image
FROM php:8.0-fpm

# Set the working directory in the container
WORKDIR /var/www

# Install dependencies
RUN apt-get update && \
    apt-get install -y libpng-dev libjpeg62-turbo-dev libfreetype6-dev locales zip unzip git libonig-dev wget && \
    docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Update composer
RUN composer self-update

# Copy composer.lock and composer.json
COPY Projet/composer.lock Projet/composer.json /var/www/

# Install Symfony CLI
RUN wget https://get.symfony.com/cli/installer -O - | bash && \
    mv /root/.symfony5/bin/symfony /usr/local/bin/symfony

# Install all PHP dependencies
RUN composer install --no-interaction --optimize-autoloader --no-dev --no-plugins --no-scripts

# Copy existing application directory contents
WORKDIR /var/www

# Copy existing application directory contents
COPY . /var/www

# Make port 80 available to the world outside this container
EXPOSE 8000

# Change current user to www
RUN chown -R www-data:www-data /var/www

# Define environment variable
ENV SYMFONY_ENV dev
