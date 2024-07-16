#!/bin/bash

docker run -d \
  --name nifi \
  --hostname nifi \
  --network net-cloudera \
  -p 9001:9001 \
  -p 9002:9002 \
  -e NIFI_WEB_HTTP_PORT_HOST=0.0.0.0 \
  -e NIFI_WEB_HTTP_PORT='9001' \
  -e NIFI_WEB_HTTPS_PORT_HOST=0.0.0.0 \
  -e NIFI_WEB_HTTPS_PORT='9002' \
  -e SINGLE_USER_CREDENTIALS_USERNAME=docente \
  -e SINGLE_USER_CREDENTIALS_PASSWORD=CorsoETL2024! \
  -v vol-nifi-logs:/opt/nifi/nifi-current/logs \
  -v vol-nifi-repo:/opt/nifi/nifi-current/database_repository \
  -v vol-nifi-state:/opt/nifi/nifi-current/state \
  -v vol-nifi-repo-cont:/opt/nifi/nifi-current/content_repository \
  -v vol-nifi-conf:/opt/nifi/nifi-current/conf \
  -v vol-nifi-flow:/opt/nifi/nifi-current/flowfile_repository \
  -v vol-nifi-repo-prov:/opt/nifi/nifi-current/provenance_repository \
  apache/nifi:latest


 