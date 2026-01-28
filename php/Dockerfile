FROM php:8.2-fpm

# 替换为阿里云源
RUN sed -i 's/deb.debian.org/mirrors.aliyun.com/g' /etc/apt/sources.list.d/debian.sources && \
    sed -i 's/debian-security/mirrors.aliyun.com\/debian-security/g' /etc/apt/sources.list.d/debian.sources && \
    sed -i 's/mirrors.aliyun.com\/mirrors.aliyun.com/mirrors.aliyun.com/g' /etc/apt/sources.list.d/debian.sources

# 安装系统依赖包
RUN apt-get update && apt-get install -y \
    libzip-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    git \
    curl \
    libxml2-dev \
    default-mysql-client \
    default-mysql-server \
    libssl-dev \
    openssl \
    libmariadb-dev \
    libcares-dev \
    libcurl4-openssl-dev

# 配置、安装和启用PHP扩展
RUN docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install -j$(nproc) \
    zip \
    soap \
    exif \
    bcmath \
    mysqli \
    pdo \
    pdo_mysql \
    gd \
    sockets \
    pcntl

RUN pecl install -D 'enable-swoole-pgsql="no" with-swoole-odbc="no" with-swoole-oracle="no" enable-swoole-sqlite="no" enable-swoole-thread="no" enable-iouring="no" enable-brotli="no" enable-zstd="no" enable-sockets="no" enable-openssl="yes" enable-http2="yes" enable-mysqlnd="yes" enable-swoole-json="no" enable-swoole-curl="no" enable-cares="yes"' swoole
# 安装和启用PECL扩展
RUN pecl install redis mongodb-1.21.0 opentelemetry && \
    docker-php-ext-enable bcmath redis mongodb opentelemetry mysqli swoole

# 安装Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# 清理系统缓存
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /var/html

# 创建目录、设置权限和创建调试文件
RUN mkdir -p /var/log/php /etc/foxitcloud && \
    chown -R www-data:www-data /var/log/php /var/html /etc/foxitcloud 