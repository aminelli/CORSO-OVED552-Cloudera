#!/bin/bash


docker run -d \
  --name sp-master \
  --hostname sp-master \
  --network net-cloudera \
  -p 9080:8080 \
  -p 7077:7077 \
  -p 6066:6066 \
  -p 4040:4040 \
  -v ./spark/master/conf:/opt/spark/conf/ \
  spark \
  sh -c "/opt/spark/sbin/start-master.sh -p 7077 --properties-file /opt/spark/conf/spark-defaults.conf && tail -f /opt/spark/logs/spark--org.apache.spark.deploy.master.Master-1-sp-master.out"


read -p "Press enter to continue"

docker run -d \
  --name sp-worker-01 \
  --hostname sp-worker-01 \
  --network net-cloudera \
  -p 9081:8081 \
  -p 7040:4040 \
  -v ./spark/worker/conf:/opt/spark/conf/ \
  spark \
  sh -c "/opt/spark/sbin/start-worker.sh -p 7077 --properties-file /opt/spark/conf/spark-defaults.conf spark://sp-master:7077 && tail -f /opt/spark/logs/spark--org.apache.spark.deploy.worker.Worker-1-sp-worker-01.out"

docker run -d \
  --name sp-worker-02 \
  --hostname sp-worker-02 \
  --network net-cloudera \
  -p 9082:8081 \
  -p 7041:4040 \
  -v ./spark/worker/conf:/opt/spark/conf/ \
  spark \
  sh -c "/opt/spark/sbin/start-worker.sh -p 7077 --properties-file /opt/spark/conf/spark-defaults.conf spark://sp-master:7077 && tail -f /opt/spark/logs/spark--org.apache.spark.deploy.worker.Worker-1-sp-worker-02.out"

