# Use the official PHP image
FROM php:8.1.0-apache

# Set the working directory
WORKDIR /var/www/html

RUN a2enmod rewrite

# Install system dependencies and the GD extension dependencies
RUN apt-get update && apt-get install -y libpng-dev libjpeg-dev libfreetype6-dev zip unzip
RUN apt-get clean

# Install PHP extensions
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd pdo pdo_mysql


# Copy the Laravel application files
COPY . .

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Expose the port
EXPOSE 9000