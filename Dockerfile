#
# Build Loowid Image
#
FROM       node:0.10.33

MAINTAINER loowid <loowid@gmail.com>

# Installation:
# Import MongoDB public GPG key AND create a MongoDB list file
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
RUN echo 'deb http://downloads-distro.mongodb.org/repo/debian-sysvinit dist 10gen' | tee /etc/apt/sources.list.d/mongodb.list

# Update apt-get sources AND install MongoDB
RUN apt-get update && apt-get install -y mongodb-org=2.6.1 mongodb-org-server=2.6.1 mongodb-org-shell=2.6.1 mongodb-org-mongos=2.6.1 mongodb-org-tools=2.6.1

# Download and install loowid source
RUN git clone https://github.com/loowid/loowid /opt/loowid
RUN cd /opt/loowid;git checkout 1.0.0;npm install --production

# Create the MongoDB data directory
RUN mkdir -p /opt/loowid/data/db

# Create self signed certificate
RUN openssl genrsa -out /opt/loowid/private.pem 1024
RUN openssl req -new -key /opt/loowid/private.pem -out /opt/loowid/public.csr -subj "/C=ES/ST=None/L=None/O=None/OU=None/CN=localhost"
RUN openssl x509 -req -days 366 -in /opt/loowid/public.csr -signkey /opt/loowid/private.pem -out /opt/loowid/public.pem

# Expose https port from the container to the host
EXPOSE 443

# Work directory
WORKDIR /opt/loowid

# Run server
CMD npm start
