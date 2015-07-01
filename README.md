# xcezx/q4m

Base docker image to run MySQL database server with Q4M

## Usage

To run the image

```
docker run --name q4m -d xcezx/q4m
```
### Environment variables

#### `MYSQL_VERSION`

default is `5.6.25`

example:

    docker run --name q4m -e MYSQL_VERSION=percona-5.6.16-64.2 -d xcezx/q4m

#### `Q4M_VERSION`

default is `0.9.14`

example:

    docker run --name q4m -e Q4M_VERSION=master -d xcezx/q4m

#### `MYSQL_ROOT_PASSWORD`

default is `p4ssw0rd`

example:

    docker run --name q4m -e MYSQL_ROOT_PASSWORD=blhablhablha -d xcezx/q4m

#### `MYSQL_USER`, `MYSQL_USER_PASSWORD`

example:

    docker run --name q4m -e MYSQL_USER=john -e MYSQL_USER_PASSWORD=p4ssw0rd -d xcezx/q4m

#### `MYSQL_DATABASE`

example:

    docker run --name q4m -e MYSQL_DATABASE=sample -d xcezx/q4m
