# COMPOSE ENV SETUP


## dependencies
* docker: [https://www.docker.com/](https://www.docker.com/)
* docker-compose: [https://docs.docker.com/compose/](https://docs.docker.com/compose/)


## start docker
* build docker image by running `docker-compose build`
* start docker image by running `docker-compose up`
* check docker inforation by running `docker-compose ps`
* identify the docker inforation by running `docker inspect <docker-name>`


## stop docker
* `docker-compose kill`
* `docker-compose rm`


## command
* connect to mysql `mysql -ujnpl -pjohnpaul -h127.0.0.1 -P3308 docker_db`
* connect to redis `redis-cli -h 127.0.0.1 -p 6378`
* connect to filesystem `docker run -t -i website /bin/bash`
