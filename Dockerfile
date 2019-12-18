# thanks: https://wiki.factorio.com/Multiplayer

FROM ubuntu:18.04

# the version of Factorio to install
ARG FACTORIO_VERSION=0.17.79
# the user that will run the factorio server
ARG FACTORIO_USER=engineer
# the password for the user that runs the factorio server
ARG FACTORIO_PASSWORD

# install necessary utilities
RUN apt-get update && apt-get install -y \
        xz-utils

# download the Factorio headless server
ADD https://www.factorio.com/get-download/${FACTORIO_VERSION}/headless/linux64 /opt/factorio_headless.tar.xz

# unzip the server binary into the appropriate directory
RUN tar -xJf /opt/factorio_headless.tar.xz --directory /opt/.

# create a new user specifically for running the server
RUN useradd -s /bin/bash -p ${FACTORIO_PASSWORD} ${FACTORIO_USER}

# give the new user ownership of the server directories
RUN chown -R ${FACTORIO_USER}:${FACTORIO_USER} /opt/factorio

# set the default user
USER ${FACTORIO_USER}

# set default work directory to server installation directory
WORKDIR /opt/factorio

# set the default entrypoint to run the factorio command
ENTRYPOINT ["./bin/x64/factorio"]

# run with the help flag if no other commands provided
CMD ["--help"]