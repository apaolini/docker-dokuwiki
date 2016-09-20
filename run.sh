#!/bin/sh

# Sample run script, with the container in a own network

cd $(dirname $0)

NETNAME=webbone

if docker network inspect $NETNAME > /dev/null ; then
  :
else
  echo "Creating network $NETNAME"
  docker network create $NETNAME
fi



docker run \
  --name dokuwiki \
  -v $(pwd)/dokuwiki/conf/:/var/www/dokuwiki/conf/ \
  -v $(pwd)/dokuwiki/data/:/var/www/dokuwiki/data/ \
  -v $(pwd)/dokuwiki/lib/plugins/:/var/www/dokuwiki/lib/plugins/ \
  -v $(pwd)/dokuwiki/lib/tpl/:/var/www/dokuwiki/lib/tpl/ \
  -d --restart=always \
  --net=$NETNAME \
  apaolini/dokuwiki

docker exec dokuwiki /bin/rm /var/www/dokuwiki/install.php
