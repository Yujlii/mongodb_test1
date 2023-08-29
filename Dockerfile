# Use a Python 3.8 base image
FROM python:3.8

# Install necessary dependencies
RUN apt-get update && \
    apt-get install -y wget && \
    apt-get clean

# Download MongoDB tarball
RUN wget -O mongodb.tar.gz \
    "https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-ubuntu2004-5.0.3.tgz"

# Extract MongoDB
RUN tar -zxvf mongodb.tar.gz -C /opt/ && \
    mv /opt/mongodb-linux-x86_64-ubuntu2004-5.0.3 /opt/mongodb && \
    rm mongodb.tar.gz

# Optionally, expose the MongoDB ports
EXPOSE 27017

# Start MongoDB on container startup
CMD ["/opt/mongodb/bin/mongod", "--bind_ip", "0.0.0.0"]
