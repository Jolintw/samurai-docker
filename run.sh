#!/bin/bash

version_tag=0.0.0
image_name=samurai-2004
container_name=samurai-2004

mode=$1
debug=$2

if [[ $mode == "build" ]]; then
    docker rmi $(docker images | grep ${image_name} | awk '{print $3}')
    docker build -t ${image_name}:${version_tag} image
    # docker tag ${image_name}:${version_tag} b07209016/${image_name}:latest
    # docker push b07209016/${image_name}:latest
    docker rmi $(docker images | grep none | awk '{print $3}')
fi

if [[ $mode == "run" ]]; then
    if [[ $debug == "debug" ]]; then
        docker run -it --rm --name ${container_name} ${image_name}:${version_tag} /bin/bash
    fi
fi