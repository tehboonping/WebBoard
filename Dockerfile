FROM php:7.3.4-apache AS web
RUN echo "file_uploads = On\n" \
         "memory_limit = 500M\n" \
         "upload_max_filesize = 500M\n" \
         "post_max_size = 500M\n" \
         "max_execution_time = 600\n" \
         > /usr/local/etc/php/conf.d/uploads.ini
RUN docker-php-ext-install mysqli
RUN pecl install redis \
	&& docker-php-ext-enable redis
COPY ./app/web /var/www/html
COPY ./aws /var/www/html/aws
RUN chmod -R 777 /var/www/html
VOLUME ["/var/www/html"]


FROM php:7.3.4-apache AS manager
RUN echo "file_uploads = On\n" \
         "memory_limit = 500M\n" \
         "upload_max_filesize = 500M\n" \
         "post_max_size = 500M\n" \
         "max_execution_time = 600\n" \
         > /usr/local/etc/php/conf.d/uploads.ini
RUN docker-php-ext-install mysqli
COPY ./app/manager /var/www/html
COPY ./aws /var/www/html/aws
RUN chmod -R 777 /var/www/html
VOLUME ["/var/www/html"]