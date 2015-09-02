FROM centos:centos6

ENV MYSQL_VERSION 5.6.25
ENV Q4M_VERSION 0.9.14
ENV TZ UTC
ENV PATH /usr/local/mysql/bin:$PATH

WORKDIR /opt
RUN groupadd -r mysql && useradd -r -g mysql mysql \
    && yum -y install curl tar gcc gcc-c++ cmake ncurses-devel libaio-devel perl \
    && yum -y clean all \
    && ln -sf /usr/share/zoneinfo/$TZ /etc/localtime \
    && mkdir -p /usr/local/mysql
RUN curl -s -L https://github.com/kamipo/mysql-build/archive/master.tar.gz | tar -C /opt --extract --gzip \
    && ./mysql-build-master/bin/mysql-build --verbose $MYSQL_VERSION /usr/local/mysql q4m-$Q4M_VERSION \
    && rm -rf ./mysql-build-master \
    && rm -rf /usr/local/mysql/data
VOLUME /usr/local/mysql

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 3306
CMD ["mysqld", "--user=mysql"]
