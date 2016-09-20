Dokuwiki docker image
=====================

[Dokuwiki](https://www.dokuwiki.org/) running on lighttpd

The wiki is published on /dokuwiki , the setup interface is on
/dokuwiki/install.php

Running
-------

### Simple run ###

* Run: `docker run -d -p 8080:80 apaolini/dokuwiki`
* Go to http://127.0.0.1:8080/dokuwiki/install.php and setup the wiki engine
* The wiki will be available on http://127.0.0.1:8080/dokuwiki/doku.php

### Run persisting data and configurations ###
```
docker run \
  -v /data/dokuwiki/conf/:/var/www/dokuwiki/conf/ \
  -v /data/dokuwiki/data/:/var/www/dokuwiki/data/ \
  -v /data/dokuwiki/lib/plugins/:/var/www/dokuwiki/lib/plugins/ \
  -v /data/dokuwiki/lib/tpl/:/var/www/dokuwiki/lib/tpl/ \
  apaolini/dokuwiki
```
`run.sh` is a sample script for running the image mounting the data from the local directory.

Build
-----
    docker build -t apaolini/dokuwiki .

Caveat
------
After the first configuration remember to disable the administration interface removing the `install.php` file, like that:

    docker exec <DOKUWIKI_CONTAINERAME> /bin/rm /var/www/dokuwiki/install.php
