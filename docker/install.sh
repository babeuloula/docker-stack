#!/usr/bin/env bash

set -e

readonly DOCKER_PATH=$(dirname $(realpath $0))

cd ${DOCKER_PATH};

. ./lib/functions.sh

block_info "Welcome to your Docker stack installer!"

check_requirements

if [[ -f "./docker-compose.yaml" ]]; then
    block_error "You already have a docker-compose.yaml file. Remove this file before install."
    exit 1
fi

parse_env_docker

readonly use_mysql=$(ask_value "Do you want to use MySQL?" "yes")

if [[ "yes" == "${use_mysql}" ]]; then
    parse_env "./mysql/.env.dist" "./.env"
    parse_env "./mysql/${ENV}/.env.dist" "./.env"
fi

block_success "Configuration done!"

merge_yaml "./docker-compose.base.tpl.yaml"

merge_yaml "./nginx/docker-compose.base.tpl.yaml"
merge_yaml "./nginx/${ENV}/docker-compose.tpl.yaml"

merge_yaml "./php/docker-compose.base.tpl.yaml"

if [[ "yes" == ${use_mysql} ]]; then
    merge_yaml "./mysql/docker-compose.base.tpl.yaml"
    merge_yaml "./mysql/${ENV}/docker-compose.tpl.yaml"
    merge_yaml "./mysql/docker-compose.end.tpl.yaml"
fi

merge_yaml "./docker-compose.end.tpl.yaml"

block_success "Docker compose file generated with success!."

docker-compose build --parallel
if [[ -z "$(docker network ls -f name="${NETWORK}" --format "{{.Name}}")" ]]; then
    docker network create "${NETWORK}"
fi
docker-compose up -d

if [[ "none" != "${SYMFONY_VERSION}" ]]; then
    if [[ ! -f "../bin/console" ]]; then
        exec_php "symfony" "new --dir=./symfony_tmp --version ${SYMFONY_VERSION}"

        mv ../symfony_tmp/.env ../
        mv ../symfony_tmp/.gitignore ../
        mv ../symfony_tmp/* ../
        rm -rf ../symfony_tmp

        exec_php "chown" "-R docker /var/www/html"
    else
        block_info "A Symfony installation was found. No need to re-install it."
    fi

    if [[ "yes" == "${use_mysql}" ]]; then
        exec_php "composer require symfony/orm-pack"

        if [[ "dev" == "${ENV}" ]]; then
            exec_php "composer require --dev symfony/maker-bundle"
        fi
    fi
fi

delete_dot_git

if [[ "dev" == "${ENV}" ]]; then
    if [[ "localhost" != "${HTTP_HOST}" ]]; then
        add_host "${HTTP_HOST}"
    fi

    block_success "Environment is started, you can go to http://${HTTP_HOST}:${HTTP_PORT}"
else
    block_success "Environment is started!"
fi
