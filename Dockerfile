FROM resin/rpi-raspbian:wheezy

# mongodb user
RUN groupadd -r mongodb && useradd -r -g mongodb mongodb

# Install mongo to /opt/mongo
RUN sudo apt-get update
RUN sudo apt-get install -y curl
RUN sudo apt-get install -y p7zip-full
RUN curl -O http://facat.github.io/mongodb-2.6.4-arm.7z
RUN 7z x mongodb-2.6.4-arm.7z
RUN mv mongodb /opt/mongodb
RUN rm -f mongodb-2.6.4-arm.7z
RUN sudo chown -R mongodb /opt/mongodb

# Create the mongo data dirs
RUN sudo mkdir -p /data/db && \
    sudo chown mongodb /data/db

# Create runtime directories under /var
RUN install -o mongodb -g mongodb -d /var/log/mongodb/ && \
    install -o mongodb -g mongodb -d /var/lib/mongodb/

# Install config scripts
ADD mongodb.conf .
RUN install mongodb.conf /etc

VOLUME /data/db

EXPOSE 27017
CMD ["/opt/mongodb/bin/mongod"]
