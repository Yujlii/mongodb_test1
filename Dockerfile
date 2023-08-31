# Use a Python 3.8 base image
FROM python:3.8

# Download and setup MongoDB
RUN wget -O mongodb.tar.gz \
    "https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-ubuntu2004-5.0.3.tgz" 
RUN tar -zxvf mongodb.tar.gz -C /opt/
RUN mv /opt/mongodb-linux-x86_64-ubuntu2004-5.0.3 /opt/mongodb 
RUN rm mongodb.tar.gz

# Setup data directory and permissions
RUN mkdir -p /data/db && \
    useradd -ms /bin/bash mongodb && \
    chown -R mongodb:mongodb /data/db

# Expose MongoDB port
EXPOSE 27017

# Ensure that MongoDB can be accessed system-wide (Optional step)
ENV PATH="/opt/mongodb/bin:$PATH"

# Start MongoDB on container startup
CMD ["/opt/mongodb/bin/mongod", "--bind_ip", "0.0.0.0", "--logpath", "/var/log/mongodb.log"]
