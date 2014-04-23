#!/bin/bash
# Only run on Name Node
# Check for valid number of arguments
function rsyncdir {
   node=$1
   t_dir=$2
   sudo -u hdfs rsync -avs --delete  ${t_dir} hdfs@${node}:${t_dir}
}

if [ $# -ne 4 ]; then
    echo "Usage: $0 ENV(dev|qa|prod) startnode(301) endnode(303) /etc/hadoo/conf.empty/"
    exit 0
fi
env=$1
node1=$2
node2=$3
conf_dir=$4
i=$node1
echo "Pushing config from Name Node to Master Nodes"
while [ $i -le $node2 ]
do
    node=${MASTER_HOST_PREFIX}{i}.${env}.${MASTER_HOST_SUFFIX}
    echo "Pushing $conf_dir to $node "
    rsyncdir $node $conf_dir 
    i=`expr $i + 1`
done
