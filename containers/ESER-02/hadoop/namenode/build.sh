#!/bin/bash

. ../build-env.sh

docker build --no-cache -t $BASE_TAG-namenode:$TAG_IMAGE .

