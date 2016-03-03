FROM centos:centos6
MAINTAINER xcezx <main.xcezx@gmail.com>

ARG MYSQL_VERSION
ENV MYSQL_VERSION ${MYSQL_VERSION:-5.6.25}
ARG Q4M_VERSION
ENV Q4M_VERSION ${Q4M_VERSION:-0.9.14}
ARG TZ
ENV TZ ${TZ:-UTC}
ENV PATH /usr/local/mysql/bin:$PATH

RUN ln -sf /usr/share/zoneinfo/$TZ /etc/localtime

WORKDIR /usr/local/src

RUN yum -y install curl tar gcc gcc-c++ cmake ncurses-devel libaio-devel perl \
    && yum -y clean all

RUN mkdir /usr/local/src/mysql-build \
    && curl -s -L https://github.com/kamipo/mysql-build/archive/master.tar.gz | tar --verbose --extract --gzip --directory /usr/local/src/mysql-build --strip-components 1 \
    && ./mysql-build/bin/mysql-build --verbose $MYSQL_VERSION /usr/local/mysql q4m-$Q4M_VERSION \
    && rm -rf /usr/local/src/mysql-build

RUN groupadd -r mysql && useradd -r -g mysql mysql

VOLUME /usr/local/mysql
WORKDIR /usr/local/mysql

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 3306
CMD ["mysqld", "--user=mysql"]
