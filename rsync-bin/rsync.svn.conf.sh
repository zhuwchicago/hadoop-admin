#!/bin/bash
# Only run on Name Node
# Check for valid number of arguments
function rsyncdir {
   node=$1
   env=$2
   t_dir=$3
   t_dir2=${SVN_LOCATION}/${env}${t_dir}
   echo $t_dir2
   rsync -avs --delete  ${t_dir} ${node}:${t_dir2}
}

if [ $# -ne 3 ]; then
    echo "Usage: $0 ENV(dev|qa|prod) remote_host /etc/hadoo/conf"
    exit 0
fi
env=$1
node=$2
conf_dir=$3
echo "Pushing $conf_dir to $node in SVN "
rsyncdir $node $conf_dir 
