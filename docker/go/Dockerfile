FROM golang:1.20

ARG CONTAINER_PACKAGE_URL

ENV DEBIAN_FRONTEND noninteractive

# CST zone
ENV TZ=Asia/Shanghai

ENV CGO_ENABLED 0
ENV GOPROXY https://goproxy.cn,direct
ENV GO111MODULE on


RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN sed -i 's@http://deb.debian.org@http://mirrors.ustc.edu.cn@g' /etc/apt/sources.list

RUN apt-get clean \
    && apt-get update \
    && apt-get install -y libmcrypt-dev libcurl4-openssl-dev libssl-dev zlib1g-dev libicu-dev g++ \
        libmagickwand-dev libmagickcore-dev pkg-config vim mcrypt zip unzip \
        iputils-ping redis-tools supervisor \
    && apt-get install -y git git-lfs \
    && git lfs install \
    && apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libpng-dev \
    && apt-get install -y libonig-dev \
    && apt-get install -y libzip-dev

ENTRYPOINT ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]

WORKDIR /var/www/html
