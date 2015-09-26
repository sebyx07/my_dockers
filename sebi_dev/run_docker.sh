#!/bin/bash
mkdir -p $HOME/db
mkdir -p $HOME/db/postgres
mkdir -p $HOME/db/mongo
mkdir -p $HOME/docker
mkdir -p $HOME/docker/ruby_gems
mkdir -p $HOME/docker/ruby_gems/2.2.2

docker-compose run sebi_dev /bin/bash