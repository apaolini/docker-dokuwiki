# DEPRECATED and NO LONGER MANTAINED #
# DEPRECATED and NO LONGER MANTAINED #
# DEPRECATED and NO LONGER MANTAINED #


Dokuwiki docker image
=====================

[Dokuwiki](https://www.dokuwiki.org/) running on lighttpd

The wiki is published on /dokuwiki , the setup interface is on
/dokuwiki/install.php

[![](https://images.microbadger.com/badges/image/apaolini/dokuwiki.svg)](https://microbadger.com/images/apaolini/dokuwiki "Get your own image badge on microbadger.com")

Running
-------

### Simple run ###

* Run: `docker run -d -p 8080:80 apaolini/dokuwiki`
* Go to http://127.0.0.1:8080/dokuwiki/install.php and setup the wiki engine
* The wiki will be available on http://127.0.0.1:8080/dokuwiki/doku.php

### Run persisting data and configurations ###
```
docker run -d -p 8080:80 \
  -v /data/dokuwiki/conf/:/var/www/html/dokuwiki/conf/ \
  -v /data/dokuwiki/data/:/var/www/html/dokuwiki/data/ \
  apaolini/dokuwiki
```
`run.sh` (in the github repo) is a sample script for running the image mounting the data from the local directory.

Build
-----
    docker build -t apaolini/dokuwiki .

Caveat
------
After the first configuration remember to disable the administration interface removing the `install.php` file, like that:

    docker exec <DOKUWIKI_CONTAINERNAME> /bin/rm /var/www/html/dokuwiki/install.php
