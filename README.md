# docker-q4m

## 使い方

### コンテナの起動

```
docker run --name q4m -d xcezx/q4m
```

### 環境変数

#### `MYSQL_VERSION`

初期値 (`5.6.22`) から変更したい場合にどうぞ。

example:

    docker run --name q4m -e MYSQL_VERSION=percona-5.6.16-64.2 -d xcezx/q4m

#### `Q4M_VERSION`

初期値 (`0.9.14`) から変更したい場合にどうぞ。

example:

    docker run --name q4m -e Q4M_VERSION=master -d xcezx/q4m

#### `MYSQL_ROOT_PASSWORD`

初期値 (`p4ssw0rd`) から変更したい場合にどうぞ。

example:

    docker run --name q4m -e MYSQL_ROOT_PASSWORD=blhablhablha -d xcezx/q4m

#### `MYSQL_USER`, `MYSQL_USER_PASSWORD`

`root` ユーザ以外にユーザを作りたい場合にどうぞ。

example:

    docker run --name q4m -e MYSQL_USER=john -e MYSQL_USER_PASSWORD=p4ssw0rd -d xcezx/q4m

#### `MYSQL_DATABASE`

コンテナ起動時にデータベースを作成して欲しい場合にどうぞ。

example:

    docker run --name q4m -e MYSQL_DATABASE=sample -d xcezx/q4m

