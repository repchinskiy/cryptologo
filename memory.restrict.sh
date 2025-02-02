#!/bin/bash
mount | grep cgroup
echo "+memory" | sudo tee /sys/fs/cgroup/cgroup.subtree_control
sudo mkdir /sys/fs/cgroup/$1
echo $(($3 * 1024 * 1024 * 1024)) | sudo tee /sys/fs/cgroup/$1/memory.max
#echo $(pgrep -f $2) | sudo tee /sys/fs/cgroup/$1/cgroup.procs
echo $2 | sudo tee /sys/fs/cgroup/$1/cgroup.procs
