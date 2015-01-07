#!/bin/bash
set -e

rm -f /etc/localtime
cp -p /usr/share/zoneinfo/$TZ /etc/localtime

if [ ! -d "/usr/local/mysql/data" ]; then
	./mysql-build-master/bin/mysql-build --verbose $MYSQL_VERSION /usr/local/mysql q4m-$Q4M_VERSION
	cd /usr/local/mysql
	chown -R mysql:mysql .
	./scripts/mysql_install_db --user=mysql
	chown -R root .
	chown -R mysql data

	TMPFILE=$(mktemp)
        chmod 0666 $TMPFILE
	cat > $TMPFILE <<-EOSQL
		DELETE FROM mysql.user ;
		CREATE USER 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD' ;
		GRANT ALL ON *.* TO 'root'@'%' WITH GRANT OPTION ;
		DROP DATABASE IF EXISTS test ;
	EOSQL

	if [ "$MYSQL_DATABASE" ]; then
		echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE ;" >> $TMPFILE
	fi

	if [ "$MYSQL_USER" -a "$MYSQL_USER_PASSWORD" ]; then
		echo "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_USER_PASSWORD' ;" >> $TMPFILE
		if [ "$MYSQL_DATABASE" ]; then
			echo "GRANT ALL ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' WITH GRANT OPTION ;" >> $TMPFILE
		fi
	fi

	echo "FLUSH PRIVILEGES ;" >> $TMPFILE
	cat /usr/local/mysql/support-files/install-q4m.sql >> $TMPFILE

	set -- "$@" --init-file=$TMPFILE
fi

exec "$@"
