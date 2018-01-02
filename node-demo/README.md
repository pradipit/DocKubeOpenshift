minishift docker-env

docker build -t pc/mynode:v1 .

docker images | grep mynode

docker run -d -p 8000:8000 pc/mynode:v1

docker ps | grep mynode

docker exec -it fe2ab3012e69 /bin/bash

cat /etc/system-release

exit

docker stop fe2ab3012e69

docker rm fe2ab3012e69