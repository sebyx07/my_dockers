#!/bin/bash
mkdir -p $HOME/db
mkdir -p $HOME/db/postgres
mkdir -p $HOME/db/mongo

docker-compose run sebi_dev /bin/bash