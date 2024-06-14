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

# Install Symfony CLI
RUN wget https://get.symfony.com/cli/installer -O - | bash && \
    mv /root/.symfony5/bin/symfony /usr/local/bin/symfony

# Initialize composer.json and install dependencies
RUN composer init --no-interaction --require=symfony/framework-bundle:^5.3 && \
    composer install --no-interaction --optimize-autoloader --no-dev

# Install Twig
RUN composer require twig/twig

# Copy existing application directory contents
COPY . /var/www/

# Make port 80 available to the world outside this container
EXPOSE 8000

# Define environment variable
ENV SYMFONY_ENV dev