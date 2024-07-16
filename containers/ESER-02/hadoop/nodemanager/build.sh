#!/bin/bash

. ../build-env.sh

docker build --no-cache -t $BASE_TAG-nodemanager:$TAG_IMAGE .

