#!/bin/sh

# don't check file mode in git
git config core.fileMode false
git submodule foreach git config core.filemode false

# set storage file mode to 0777
chmod -R 0777 code/api/storage

# copy laravel development config
cp code/api/.env.development code/api/.env

docker-compose build

# running composer install
cd code/api
composer install
# Licards farm

    git clone --recursive https://github.com/licards/farm.git
    cd farm

    sudo bash build-local-farm.sh
    docker-compose up
# running npm install
cd ../web
npm install

# building the application before serving it
npm run build