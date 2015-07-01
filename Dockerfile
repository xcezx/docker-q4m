FROM centos:centos6
MAINTAINER xcezx <main.xcezx@gmail.com>

ENV MYSQL_VERSION 5.6.25
ENV MYSQL_ROOT_PASSWORD p4ssw0rd
ENV Q4M_VERSION 0.9.14
ENV TZ UTC

WORKDIR /tmp/workdir

RUN yum -y install curl tar gcc gcc-c++ cmake ncurses-devel libaio-devel perl && \
    yum -y clean all

RUN groupadd -r mysql && useradd -r -g mysql mysql
RUN curl -s -L https://github.com/kamipo/mysql-build/archive/master.tar.gz | tar vzx

RUN mkdir -p /usr/local/mysql
VOLUME /usr/local/mysql

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 3306
CMD ["/usr/local/mysql/bin/mysqld_safe", "--user=mysql"]
