FROM mysql:8.0.16

ARG CONTAINER_PACKAGE_URL

ENV DEBIAN_FRONTEND noninteractive

# CST zone
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
