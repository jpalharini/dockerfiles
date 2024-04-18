FROM debian:stable-slim as base

RUN apt update

RUN apt -y install \
    libavahi-client-dev \
    libgnutls28-dev \
    libkrb5-dev \
    libnss-mdns \
    libpam-dev \
    libsystemd-dev \
    libusb-1.0-0-dev \
    zlib1g-dev

FROM base as build

RUN apt -y install \
    curl \
    epm \
    autoconf \
    build-essential

RUN curl -sLO https://github.com/OpenPrinting/cups/releases/download/v2.4.7/cups-2.4.7-source.tar.gz && tar -xf cups-2.4.7-source.tar.gz

WORKDIR /cups-2.4.7

RUN ./configure && make && make deb

WORKDIR /cups-2.4.7/dist

FROM base

COPY --from=build /cups-2.4.7/dist/*.deb.tgz /cups-debs.tgz

RUN mkdir cups-debs && tar -xf cups-debs.tgz -C cups-debs

WORKDIR /cups-debs
 
RUN dpkg -i --force-architecture *

EXPOSE 631