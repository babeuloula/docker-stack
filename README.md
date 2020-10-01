# Docker stack

A script to simplify creation for a docker stack with Symfony and MySQL.

This script will create a custom `docker-compose.yaml` in order to
create your own stack.

By default, this stack works with [NGINX](https://www.nginx.com/) 1.19.2
and [PHP](https://www.php.net/) 7.4 FPM. Composer is also installed by
default with PHP.

With this script, you can also install [MySQL](https://www.mysql.com/)
8.0 and Symfony.

If you set `ENV` to `dev`, you can connect to your database with
[Adminer](https://www.adminer.org/).

If you choose to install MySQL and Symfony,
[Doctrine2](https://www.doctrine-project.org/) will be directly install.

## How to use

You just have to clone this repository and execute `install.sh` from
`docker` directory.

```bash
./docker/install.sh
```

## .env variables

- `ENV` (default: `dev`)

`dev` or `prod`. Use to know if the script needs to install Adminer and
expose MySQL port.

- `SYMFONY_VERSION` (default: `none`)

What [Symfony version](https://symfony.com/doc/current/setup.html) do
you want to install. If you don't need to install Symfony, just say
`none`.

- `COMPOSE_PROJECT_NAME`

This variable avoids a docker error. By default, docker use the path to
name your project.

- `TZ` (default: `Europe/Paris`)

Timezone for PHP.

- `NETWORK` (default: `docker_stack`)

[Docker network](https://docs.docker.com/network/).

- `MYSQL_ROOT_PASSWORD` (default: `root`)

This variable specifies the password that will be set for the MySQL root
superuser account.

- `MYSQL_DATABASE` (default: `docker_stack`)

This variable allows you to specify the name of a database to be created
on image startup.

- `MYSQL_USER` (default: `docker_stack`)
- `MYSQL_PASSWORD` (default: `docker_stack`)

These variables will create a new user to set that user's password. This
user will be granted superuser permissions for the database specified by
the MYSQL_DATABASE variable.

- `HTTP_HOST` (default: `localhost`) **(`ENV=dev` only)**

This variable will create a new entry in `/etc/hosts` to allow you to
access your environnement with you web browser. If you don't want to add
an entry, just say `localhost`.

- `HTTP_PORT` (default: `8888`) **(`ENV=dev` only)**

Use to prevent conflicts with your other stacks.

- `MYSQL_PORT` (default: `3310`) **(`ENV=dev` only)**

This variable will allow you to expose MySQL if you want to read/write
with another software like [DBeaver](https://dbeaver.io/).

- `ADMINER_PORT` (default: `8012`) **(`ENV=dev` only)**

This variables will allow you to access Adminer on your local stack.    
Ex.: `http://HTTP_HOST:ADMINER_PORT`.

- `DOMAINS` **(`ENV=prod` only)**
- `LETSENCRYPT_EMAIL` **(`ENV=prod` only)**

Needed if you want to use in production mode with
[Let's Encrypt Proxy](https://github.com/evertramos/docker-compose-letsencrypt-nginx-proxy-companion)

Ex.: `DOMAINS=mywebsite.com,www.mywebsite.com`
