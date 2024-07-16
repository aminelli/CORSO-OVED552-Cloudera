#!/bin/bash

. ./hadoop/build-env.sh




cd hadoop


# NAME NODE
echo "Creazione container NAME NODE"
 
docker run -d \
  --name     $CNT_NAMENODE \
  --hostname $CNT_NAMENODE \
  --network  $DOCKER_NETWORK \
  -p 9870:9870 \
  -p 9000:9000 \
  -e CLUSTER_NAME=$CLUSTER_NAME \
  -e CORE_CONF_fs_defaultFS=hdfs://$CNT_NAMENODE:9000 \
  -e YARN_CONF_yarn_log_server_url=http://$CNT_HISTORYSERVER:8188/applicationhistory/logs/ \
  -e YARN_CONF_yarn_resourcemanager_hostname=$CNT_RESOURCEMANAGER \
  -e YARN_CONF_yarn_resourcemanager_address=$CNT_RESOURCEMANAGER:8032 \
  -e YARN_CONF_yarn_resourcemanager_scheduler_address=$CNT_RESOURCEMANAGER:8030 \
  -e YARN_CONF_yarn_resourcemanager_resource__tracker_address=$CNT_RESOURCEMANAGER:8031 \
  --env-file $ENV_FILE \
  -v $VOL_NAMENODE:/hadoop/dfs/name \
  $BASE_TAG-namenode:$TAG_IMAGE



# DATA NODE
echo "Creazione container DATA NODE"

docker run -d \
  --name     $CNT_DATANODE \
  --hostname $CNT_DATANODE \
  --network  $DOCKER_NETWORK \
  -e SERVICE_PRECONDITION="$CNT_NAMENODE:9870" \
  -e CORE_CONF_fs_defaultFS=hdfs://$CNT_NAMENODE:9000 \
  -e YARN_CONF_yarn_log_server_url=http://$CNT_HISTORYSERVER:8188/applicationhistory/logs/ \
  -e YARN_CONF_yarn_resourcemanager_hostname=$CNT_RESOURCEMANAGER \
  -e YARN_CONF_yarn_resourcemanager_address=$CNT_RESOURCEMANAGER:8032 \
  -e YARN_CONF_yarn_resourcemanager_scheduler_address=$CNT_RESOURCEMANAGER:8030 \
  -e YARN_CONF_yarn_resourcemanager_resource__tracker_address=$CNT_RESOURCEMANAGER:8031 \
  --env-file $ENV_FILE \
  -v $VOL_DATANODE:/hadoop/dfs/data \
  $BASE_TAG-datanode:$TAG_IMAGE



# RESOURCE MANAGER
echo "Creazione container RESOURCE MANAGER"

docker run -d \
  --name     $CNT_RESOURCEMANAGER \
  --hostname $CNT_RESOURCEMANAGER \
  --network  $DOCKER_NETWORK \
  -e SERVICE_PRECONDITION="$CNT_NAMENODE:9000 $CNT_NAMENODE:9870 $CNT_DATANODE:9864" \
  -e CORE_CONF_fs_defaultFS=hdfs://$CNT_NAMENODE:9000 \
  -e YARN_CONF_yarn_log_server_url=http://$CNT_HISTORYSERVER:8188/applicationhistory/logs/ \
  -e YARN_CONF_yarn_resourcemanager_hostname=$CNT_RESOURCEMANAGER \
  -e YARN_CONF_yarn_resourcemanager_address=$CNT_RESOURCEMANAGER:8032 \
  -e YARN_CONF_yarn_resourcemanager_scheduler_address=$CNT_RESOURCEMANAGER:8030 \
  -e YARN_CONF_yarn_resourcemanager_resource__tracker_address=$CNT_RESOURCEMANAGER:8031 \
  --env-file $ENV_FILE \
  $BASE_TAG-resourcemanager:$TAG_IMAGE





# NODE MANAGER
echo "Creazione container NODE MANAGER"

docker run -d \
  --name     $CNT_MODEMANAGER \
  --hostname $CNT_MODEMANAGER \
  --network  $DOCKER_NETWORK \
  -e SERVICE_PRECONDITION="$CNT_NAMENODE:9000 $CNT_NAMENODE:9870 $CNT_DATANODE:9864 $CNT_RESOURCEMANAGER:8088" \
  -e CORE_CONF_fs_defaultFS=hdfs://$CNT_NAMENODE:9000 \
  -e YARN_CONF_yarn_log_server_url=http://$CNT_HISTORYSERVER:8188/applicationhistory/logs/ \
  -e YARN_CONF_yarn_resourcemanager_hostname=$CNT_RESOURCEMANAGER \
  -e YARN_CONF_yarn_resourcemanager_address=$CNT_RESOURCEMANAGER:8032 \
  -e YARN_CONF_yarn_resourcemanager_scheduler_address=$CNT_RESOURCEMANAGER:8030 \
  -e YARN_CONF_yarn_resourcemanager_resource__tracker_address=$CNT_RESOURCEMANAGER:8031 \
  --env-file $ENV_FILE \
  $BASE_TAG-nodemanager:$TAG_IMAGE




# HISTORY SERVER
echo "Creazione container HISTORY SERVER"

docker run -d \
  --name     $CNT_HISTORYSERVER \
  --hostname $CNT_HISTORYSERVER \
  --network  $DOCKER_NETWORK \
  -e SERVICE_PRECONDITION="$CNT_NAMENODE:9000 $CNT_NAMENODE:9870 $CNT_DATANODE:9864 $CNT_RESOURCEMANAGER:8088" \
  -e CORE_CONF_fs_defaultFS=hdfs://$CNT_NAMENODE:9000 \
  -e YARN_CONF_yarn_log_server_url=http://$CNT_HISTORYSERVER:8188/applicationhistory/logs/ \
  -e YARN_CONF_yarn_resourcemanager_hostname=$CNT_RESOURCEMANAGER \
  -e YARN_CONF_yarn_resourcemanager_address=$CNT_RESOURCEMANAGER:8032 \
  -e YARN_CONF_yarn_resourcemanager_scheduler_address=$CNT_RESOURCEMANAGER:8030 \
  -e YARN_CONF_yarn_resourcemanager_resource__tracker_address=$CNT_RESOURCEMANAGER:8031 \
  --env-file $ENV_FILE \
  -v $VOL_HISTORYSERVER:/hadoop/yarn/timeline \
  $BASE_TAG-historyserver:$TAG_IMAGE



cd ..

echo "Creazione CLUSTER HADOOP '$CLUSTER_NAME' conclusa."






