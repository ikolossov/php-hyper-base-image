FROM phpswoole/swoole:php8.4-alpine
ARG APP_VERSION=unknown
ENV APP_VERSION=${APP_VERSION}
RUN apk add --no-cache tzdata
COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/
RUN install-php-extensions pdo_pgsql redis opcache pcntl
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"
COPY --from=composer:2 /usr/bin/composer /usr/local/bin/
WORKDIR /app