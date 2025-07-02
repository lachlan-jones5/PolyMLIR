#!/bin/bash

# Build Docker image from Dockerfile in current directory
IMAGE_NAME="polymlir-dev"
docker build -t $IMAGE_NAME .

# Check if the container exists
if [ "$(docker ps -a -q -f name=polymlir-dev)" ]; then
  # Start the container if it's stopped, then attach
  docker start polymlir-dev >/dev/null
  docker exec -it polymlir-dev bash
else
  # Remove any exited container with the same name
  if [ "$(docker ps -a -f status=exited -q -f name=polymlir-dev)" ]; then
    docker rm polymlir-dev >/dev/null
  fi
  # Run a new container
  docker run -it \
    -v "$(pwd)":/workspace \
    --name polymlir-dev \
    $IMAGE_NAME
fi
