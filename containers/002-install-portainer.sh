#!/bin/bash

docker volume create portainer_data

docker run -d -p 8999:8000 -p 9999:9000 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest
