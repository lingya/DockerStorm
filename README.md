# DockerStorm

You need an Zookeeper (For the moment) (sogos/DockerZookeeper for example)

To launch a master:

docker run -p 8080:8080 -p 6627:6627 -v /docker_volumes/storm:/opt/storm/logs -d -h nimbus --link zookeeper:zookeeper --name nimbus -e master=true sogos/storm

To launch a worker:

docker run --name worker1 -d --link zookeeper:zookeeper --link nimbus:nimbus sogos/storm

