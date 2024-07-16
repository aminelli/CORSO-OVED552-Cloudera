#!/bin/bash

. ./hadoop/build-env.sh


echo "Avvio BUILD immagini Hadoop."

cd hadoop

docker build --no-cache -t $BASE_TAG-base:$TAG_IMAGE ./base
docker build --no-cache -t $BASE_TAG-namenode:$TAG_IMAGE ./namenode
docker build --no-cache -t $BASE_TAG-datanode:$TAG_IMAGE ./datanode
docker build --no-cache -t $BASE_TAG-resourcemanager:$TAG_IMAGE ./resourcemanager
docker build --no-cache -t $BASE_TAG-nodemanager:$TAG_IMAGE ./nodemanager
docker build --no-cache -t $BASE_TAG-historyserver:$TAG_IMAGE ./historyserver
 
cd ..

echo "Fine BUILD immagini Hadoop"






