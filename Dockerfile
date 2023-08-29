# Use a Python 3.8 base image
FROM python:3.8

# Download MongoDB tarball
RUN wget -O mongodb.tar.gz \
    "https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-ubuntu2004-5.0.3.tgz"

# Extract MongoDB
RUN tar -zxvf mongodb.tar.gz -C /opt/
RUN mv /opt/mongodb-linux-x86_64-ubuntu2004-5.0.3 /opt/mongodb

# Clean up
RUN rm mongodb.tar.gz

# Optionally, expose the MongoDB ports
EXPOSE 27017

# You may want to configure MongoDB further, depending on your use case
# For example, set up authentication, change default passwords, etc.

# Start MongoDB on container startup
CMD ["/opt/mongodb/bin/mongod"]

