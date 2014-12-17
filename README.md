loowid-docker
=============

Docker files to build loowid docker container.

Run
======

If you want to build your own image from scratch:
  
  1. docker build -t loowid/loowid-docker github.com/loowid/loowid-docker
  2. docker run -d -p 443:443 loowid/loowid-docker
  
It is also an image available on docker hub (https://registry.hub.docker.com/u/loowid/loowid/):

  1. docker run -d -p 443:443 loowid/loowid
  2. Connect to https://localhost/
  
  
