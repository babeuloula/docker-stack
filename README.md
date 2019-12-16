# Docker stack

A script to simplify creation for a docker stack with Symfony and MySQL.

This script will create a custom `docker-compose.yaml` in order to
create your own stack.

By default, this stack works with [NGINX](https://www.nginx.com/) 1.17.6
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
