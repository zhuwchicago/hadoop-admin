#!/bin/bash
# Only run on Name Node
# Check for valid number of arguments
function rsyncdir {
   node=$1
   t_dir=$2
   sudo -u hdfs rsync -avs --delete  ${t_dir} hdfs@${node}:${t_dir}
}

if [ $# -ne 4 ]; then
    echo "Usage: $0 ENV(dev|qa|prod) startnode(301) endnode(305|310|312) /etc/hadoop/conf.empty/"
    exit 0
fi
env=$1
node1=$2
node2=$3
conf_dir=$4
i=$node1
echo "Pushing config from Name Node to Access Nodes"
while [ $i -le $node2 ]
do
    node=${ACCESS_NODE_PREFIX}${i}.${env}.${ACCESS_NODE_SUFFIX}
    echo "Pushing $conf_dir to $node "
    rsyncdir $node $conf_dir 
    i=`expr $i + 1`
done
