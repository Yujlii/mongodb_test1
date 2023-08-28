# Use an Ubuntu base image
FROM ubuntu:latest

# Install Python 3.8 and pip for Python 3.8 (if needed)
RUN apt-get update && \
    apt-get install -y python3.8 python3.8-dev python3.8-distutils && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    ln -s /usr/bin/python3.8 /usr/local/bin/python3 && \
    ln -s /usr/bin/python3.8 /usr/local/bin/python && \
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
    python get-pip.py && \
    rm get-pip.py

# Give yourself sudo access in the container (if needed)
USER root
RUN echo "ubuntu    ALL=NOPASSWD: ALL" >> /etc/sudoers

# Configure Kerberos and any other setup you need (if needed)
RUN echo '[libdefaults]\n\
  default_realm = CSLG1.CSLG.NET\n\
  clockskew = 600\n\
  dns_canonicalize_hostname = false\n\
  dns_lookup_kdc = true\n\
  forwardable = true\n\
  ignore_acceptor_hostname = true\n\
  proxiable = true\n\
  rdns = false\n\
  dns_lookup_realm = false\n\
  k5login_authoritative = false\n\
  default_tkt_enctypes = rc4-hmac\n\
  default_tgs_enctypes = rc4-hmac\n\
  udp_preference_limit = 1\n\
\n\
[realms]\n\
CSLG1.CSLG.NET = {\n\
  admin_server = kopldap.cslg1.cslg.net\n\
  kdc = kopldap.cslg1.cslg.net\n\
}\n\
\n\
[domain_realms]\n\
.cslg1.cslg.net = CSLG1.CSLG.NET' > /etc/krb5.conf

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
