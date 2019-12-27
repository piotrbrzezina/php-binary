FROM php:7.4.1-fpm-alpine3.11 as builder

RUN apk add \
       autoconf \
       dpkg-dev \
       file \
       g++ \
       gcc \
       libc-dev \
       make \
       re2c \
       gettext \
       libmcrypt-dev \
       libpng-dev \
       libxext-dev \
       libxml2-dev \
       libxrender-dev \
       bzip2-dev \
       curl-dev \
       enchant-dev \
       gmp-dev \
       imap-dev \
       openssl-dev \
       icu-dev \
       openldap-dev \
       oniguruma-dev \
       libsodium-dev \
       unixodbc-dev \
       freetds-dev \
       postgresql-dev \
       sqlite-dev \
       unixodbc-dev \
       libedit-dev \
       net-snmp-dev \
       libzip-dev \
       libxslt-dev \
       libsodium-dev \
       argon2-libs

RUN docker-php-source extract; \
	{ \
		echo '# https://github.com/docker-library/php/issues/103#issuecomment-271413933'; \
		echo 'AC_DEFUN([PHP_ALWAYS_SHARED],[])dnl'; \
		echo; \
		cat /usr/src/php/ext/odbc/config.m4; \
	} > temp.m4; \
	mv temp.m4 /usr/src/php/ext/odbc/config.m4; \
    docker-php-ext-configure odbc --with-unixODBC=shared,/usr; \
    docker-php-ext-configure pdo_odbc --with-pdo-odbc=unixODBC,/usr; \
    docker-php-ext-install odbc \
        bcmath \
        ldap \
        mbstring \
        sodium \
        mysqli \
        opcache \
        pcntl \
        pdo \
        pdo_dblib \
        pdo_mysql \
        pdo_odbc \
        pdo_pgsql \
        pdo_sqlite \
        pgsql \
        phar \
        posix \
        readline \
        session \
        shmop \
        simplexml \
        snmp \
        soap \
        sockets \
        gettext  \
        iconv  \
        imap \
        filter \
        ftp \
        gd \
        gmp  \
        bz2 \
        calendar \
        ctype \
        curl \
        dba \
        dom \
        enchant \
        exif \
        fileinfo \
        intl  \
        json \
        standard \
        sysvmsg \
        sysvsem \
        sysvshm \
        tidy \
        tokenizer \
        xml \
        xmlreader \
        xmlrpc \
        xmlwriter \
#        xsl \
        zip ; \
    docker-php-source delete

COPY phpbinary.sh  /phpbinary.sh
RUN chmod +x /phpbinary.sh; /phpbinary.sh

FROM alpine:3.11
COPY --from=builder /phpbinary/* /phpbinary/
