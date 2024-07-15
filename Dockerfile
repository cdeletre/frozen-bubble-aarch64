FROM ubuntu:20.04 as build

# avoid prompt for user input when installing tzdata
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

RUN TZ=Etc/UTC apt-get update && \
    apt-get install -y \
        git \
        cmake \
        build-essential \
        patch \
        libsdl2-dev \
        rsync \
        squashfs-tools \
        frozen-bubble

RUN mkdir /frozen-bubble
WORKDIR /frozen-bubble
