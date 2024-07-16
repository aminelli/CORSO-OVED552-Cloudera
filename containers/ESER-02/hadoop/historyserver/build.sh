#!/bin/bash

. ../build-env.sh

docker build --no-cache -t $BASE_TAG-historyserver:$TAG_IMAGE .

