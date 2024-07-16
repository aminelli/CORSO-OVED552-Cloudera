#!/bin/bash

docker volume create portainer_data

docker run -d -p 9997:8000 -p 9998:9000 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest
