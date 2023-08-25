# Use an Ubuntu base image
FROM ubuntu:latest

# Install Python 3.8 and pip for Python 3.8
RUN apt-get update && \
    apt-get install -y python3.8 python3.8-dev python3.8-distutils && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    ln -s /usr/bin/python3.8 /usr/local/bin/python3 && \
    ln -s /usr/bin/python3.8 /usr/local/bin/python && \
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
    python get-pip.py && \
    rm get-pip.py
