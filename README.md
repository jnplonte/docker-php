# LOCAL ENV SETUP

### building docker file
- docker build -t local-setup .

### running docker file
- docker run -d local-setup

### explore docker filesystem
- docker run -t -i local-setup /bin/bash

### clear docker containers
- docker stop $(docker ps -a -q)
- docker rm $(docker ps -a -q)
