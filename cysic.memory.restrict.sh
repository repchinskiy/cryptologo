#!/bin/bash
echo "+memory" | sudo tee /sys/fs/cgroup/cgroup.subtree_control
sudo mkdir /sys/fs/cgroup/cysic_node
echo $((2 * 1024 * 1024 * 1024)) | sudo tee /sys/fs/cgroup/cysic_node/memory.max
echo $(pgrep -f verifier) | sudo tee /sys/fs/cgroup/memory/cysic_node/cgroup.procs
