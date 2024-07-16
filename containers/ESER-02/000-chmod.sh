#!/bin/bash

# sudo chmod -R goa=rwx /path/to/directory


# chmod -R +x $HOME/docker 

find $HOME/docker/CORSO-OVED552-Cloudera/containers/ -name "*.sh" -exec chmod -R +x {} \;
 