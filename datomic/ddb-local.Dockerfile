FROM amazoncorretto:17

RUN yum update -y
RUN yum install -y curl unzip

WORKDIR /opt/ddb-local

RUN curl -LO "https://d1ni2b6xgvw0s0.cloudfront.net/v2.x/dynamodb_local_latest.zip" \
    && unzip "dynamodb_local_latest.zip" \
    && rm "dynamodb_local_latest.zip"