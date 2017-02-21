FROM centos:centos6

ENV MYSQL_VERSION 5.6.29
ENV Q4M_VERSION 0.9.14
ENV PATH /usr/local/mysql/bin:$PATH

RUN groupadd -r mysql && useradd -r -g mysql mysql

RUN set -x \
    && yum -y install tar gcc gcc-c++ cmake ncurses-devel perl \
    && yum -y clean all \
    && mkdir /usr/local/src/mysql-build \
    && curl -s -L https://github.com/kamipo/mysql-build/archive/master.tar.gz | tar --verbose --extract --gzip --directory /usr/local/src/mysql-build --strip-components 1 \
    && /usr/local/src/mysql-build/bin/mysql-build --verbose $MYSQL_VERSION /usr/local/mysql q4m-$Q4M_VERSION \
    && rm -rf /usr/local/src/mysql-build \
    && yum -y remove tar gcc gcc-c++ cmake ncurses-devel

VOLUME /usr/local/mysql/data
WORKDIR /usr/local/mysql

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 3306
CMD ["mysqld", "--user=mysql"]
