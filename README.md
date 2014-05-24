Dropbox client docker image
===========================

A simple image for Dropbox' official client.

Usage
=====

Assuming you want to mount Dropbox' working directories on the host (kind of
not very useful if you don't):

```shellsession
export VOLUMES=/srv/docker/volumes/dropbox
sudo mkdir -p $VOLUMES/{config,data}
docker run -d --name dropbox \
           -v $VOLUMES/config:/home/dropbox/config \
           -v $VOLUMES/data:/home/dropbox/Dropbox \
           ncadou/dropbox
```

Then grab the URL from the logs, when it appears (be patient) and authorize
the instance by opening the URL in a browser and following the instructions:

```shellsession
docker logs -f dropbox
```

That's it!
