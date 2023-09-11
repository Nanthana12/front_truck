#!/bin/bash

IMAGE=registry.ldblao.la/choulor/ldb-truck

if [ -n "$1" ]; then VERSION=$1; else VERSION="latest"; fi

echo "Building image $IMAGE:prod-$VERSION"

docker build -t $IMAGE:prod-$VERSION -f Dockerfile.prod .
docker push $IMAGE:prod-$VERSION
