# Use a Python 3.8 base image
FROM python:3.8

# Install required packages
RUN apt-get update && apt-get install -y wget

# Download and setup MongoDB
RUN wget -O mongodb.tar.gz \
    "https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-ubuntu2004-5.0.3.tgz" && \
    tar -zxvf mongodb.tar.gz -C /opt/ && \
    mv /opt/mongodb-linux-x86_64-ubuntu2004-5.0.3 /opt/mongodb && \
    rm mongodb.tar.gz

# Create data directory and permissions
RUN mkdir -p /data/db && \
    useradd -ms /bin/bash mongodb && \
    chown -R mongodb:mongodb /data/db

# Expose MongoDB port
EXPOSE 27017

# Set the MongoDB binary in PATH
ENV PATH="/opt/mongodb/bin:$PATH"

# Create a directory for your Python script
WORKDIR /app

# Copy your Python script to the container
COPY add_hello.py /app/add_hello.py

# Run the Python script when the container starts
CMD ["python", "add_hello.py"]

