# Use an Ubuntu base image
FROM ubuntu:latest

# Prevent apt from asking questions during installation
ENV DEBIAN_FRONTEND=noninteractive

# Update and install Python 3.8
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
    apt-get install -y python3.8 python3.8-venv python3.8-dev

# Add the Neo4j repository and install Neo4j
RUN wget -O - https://debian.neo4j.com/neotechnology.gpg.key | apt-key add - && \
    echo 'deb https://debian.neo4j.com stable 4.0' > /etc/apt/sources.list.d/neo4j.list && \
    apt-get update && \
    apt-get install -y neo4j

# Other Dockerfile commands...
