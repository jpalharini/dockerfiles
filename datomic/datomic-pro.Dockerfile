FROM amazoncorretto:17-alpine

ARG DATOMIC_VERSION=1.0.7075
ENV DATOMIC_VERSION=$DATOMIC_VERSION

RUN apk add curl unzip bash

RUN curl -LO "https://datomic-pro-downloads.s3.amazonaws.com/${DATOMIC_VERSION}/datomic-pro-${DATOMIC_VERSION}.zip" \
    && unzip "datomic-pro-${DATOMIC_VERSION}.zip" \
    && mv "datomic-pro-${DATOMIC_VERSION}" /opt/datomic-pro

WORKDIR /opt/datomic-pro