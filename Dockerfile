FROM brettt89/silverstripe-web:5.6-platform
MAINTAINER Lee Powell "<lee@leepowell.co.uk>"
ENV DEBIAN_FRONTEND=noninteractive

# Install zip/unzip for composer to work
RUN apt-get update -y && apt-get install -y zip
RUN docker-php-ext-install -j$(nproc) zip

# Install Apache Headers Module
RUN a2enmod headers

# Configure GD to support JPEG/PNG
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd

# Update Timezone
RUN echo "date.timezone = Europe/London" > /usr/local/etc/php/conf.d/timezone.ini
