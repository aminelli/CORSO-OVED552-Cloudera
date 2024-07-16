#!/bin/bash

## CLOUDERA CDP Private TRIAL

# USR : docente  
# PWD : CorsoETL2024!

# PUBLIC IP
# 13.70.200.197     VM-OVED552-CLOUDERA
# 13.74.222.150     VM-OVED552-CLOUDERA-HOST-01
# 52.178.140.246    VM-OVED552-CLOUDERA-HOST-02
# 13.74.220.124     VM-OVED552-CLOUDERA-HOST-03

# PRIVATE IP
# 10.5.0.22         VM-OVED552-CLOUDERA
# 10.5.0.23         VM-OVED552-CLOUDERA-HOST-01
# 10.5.0.24         VM-OVED552-CLOUDERA-HOST-02
# 10.5.0.25         VM-OVED552-CLOUDERA-HOST-03


# MAPPATURA DNS RETE INTERNA VM AZURE
# 10.5.0.22     manager.cloudera.corso.internal     VM-OVED552-CLOUDERA
# 10.5.0.23     node-01.cloudera.corso.internal     VM-OVED552-CLOUDERA-HOST-01
# 10.5.0.24     node-02.cloudera.corso.internal     VM-OVED552-CLOUDERA-HOST-02
# 10.5.0.25     node-03.cloudera.corso.internal     VM-OVED552-CLOUDERA-HOST-03

# MAPPATURA DNS INTERNET VM AZURE
# 13.70.200.197     manager.cloudera.corso.internal
# 13.74.222.150     node-01.cloudera.corso.internal
# 52.178.140.246    node-02.cloudera.corso.internal
# 13.74.220.124     node-03.cloudera.corso.internal


# PORTE MASTER: manager.cloudera.corso.internal
# 7180  manager-admin-console
# 7182  manager-agent-server-7182
# 7183  manager-agent-server-7183
# 9000  agent-port-9000
# 9001  agent-port-9001

# PORTE HOST 01: node-01.cloudera.corso.internal
# 9000  agent-port-9000
# 9001  agent-port-9001
# 9864  hdfs-http

# PORTE HOST 02: node-02.cloudera.corso.internal
# 9000      agent-port-9000
# 9001      agent-port-9001
# 9870      hdfs-console
# 14000     hdfs-http-fs
# 8083      srv-manager

# PORTE HOST 03: node-03.cloudera.corso.internal
# 9000  agent-port-9000
# 9001  agent-port-9001


== RANGER ===
Username
ranger1
 
Password
3rUhnQ6WG9

=== ZEPPELIN ===
https://community.cloudera.com/t5/Support-Questions/CDP-7-1-3-Zepplin-not-able-to-login-with-default-username/td-p/303717

=== HUE ===
Username
hue
 
Password
A2iGxN5VgN

=== DAS ===
Username
das
 
Password
iEEmGfHvtA

# === HOST NAMES ===
hostname && hostnamectl

# NOTA: cambio hostname su ogni nodo del cluster compreso il master
sudo hostnamectl set-hostname manager.cloudera.corso.internal
sudo hostnamectl set-hostname node-01.cloudera.corso.internal
sudo hostnamectl set-hostname node-02.cloudera.corso.internal
sudo hostnamectl set-hostname node-03.cloudera.corso.internal


# === PACKAGES ===
sudo apt-get update
sudo apt install -y nodejs npm yarn selinux-utils policycoreutils net-tools

curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output get-pip.py
sudo python2 get-pip.py

# DA INSTALLARE SOLO SUI NODI HOST e NON SUL MASTER
sudo pip install psycopg2==2.7.5 --ignore-installed

# TUNING LINUX: PARAMETRO swappiness
sudo nano /etc/sysctl.conf
# settare e salvare:
# vm.swappiness = 10
sudo sysctl -p
sudo sysctl vm.swappiness=10


## DISABILITARE SELINUX SU TUTTI I NODI
# view current status; 
# IMPORTANTE: Proseguire con la disabilitazione SE E SOLO se SELinux è nello stato di ENABLE
sudo sestatus

# Da fare solo nel caso in cui sestatus dia come risultato "ENABLE"
# Disable Temporarily
sudo setenforce 0

# or Disable Permanently:
cat /etc/selinux/config
# Modify :
# FROM:
# SELINUX=enforcing
# TO:
# SELINUX=disabled

# Reboot
sudo reboot

# Per Riattivare in un secondo momento:
sudo setenforce 1



# === INSTALLAZIONE CLOUDERA PRIVATE CLOUD TRIAL ===

cd $HOME
mkdir cloudera
cd cloudera

wget https://archive.cloudera.com/cm7/7.4.4/cloudera-manager-installer.bin
chmod u+x cloudera-manager-installer.bin
sudo ./cloudera-manager-installer.bin

# To observe the startup process
sudo tail -f /var/log/cloudera-scm-server/cloudera-scm-server.log

# URLS:
# http://localhost:7180/
# http://manager.cloudera.corso.internal:7180/

# usr: admin
# pwd: admin

sudo systemctl restart cloudera-scm-server

