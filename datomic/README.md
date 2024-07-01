# Datomic in Docker

This folder contains two options for running Datomic locally:
- Using the H2 database (`dev` protocol);
- Using Amazon's DynamoDB Local (`ddb-local` protocol);

## How to use/deploy these?

Simple, just do `docker compose -f <path-to-compose-file> up`. The main objective of these files is to allow for the containers to run in your local workstation and be accessible using `localhost`.

To connect, use the following URIs depending on the deployment option:
- For Datomic with H2: `datomic:dev://localhost:4334/<some-database>`
- For Datomic with DynamoDB Local: `datomic:ddb-local://localhost:8005/datomic-ddb-local/<some-database>?aws_access_key_id=DUMMYKEY&aws_secret_key=DUMMYSECRET`

## Notes

### Changing ports

- To change Datomic's port, just edit the relevant `-transactor.properties` file. If you change `ping-port`, however, make sure the healtcheck command in the Compose file is updated.
- In the DynamoDB Local deployment, when editing the port for DynamoDB, make sure to update the healthcheck command in the Compose file and `aws-dynamodb-override-endpoint` in `files/ddb-local-transactor.properties`.

## What is in these files?

### Compose files

#### `ddb-local-compose.yaml`

A stack with two containers:
- Datomic running on port 4334 and with healthcheck endpoint configured on port 9999. The container already includes healthcheck instructions.
- DynamoDB Local running on port 8005 with a makeshift healthcheck that just makes sure it's up. The HTTP request returns error code 400 but `curl` returns 0, so it's successful.

#### `h2-compose.yaml`

A stack with a Datomic container running on port 4334 and with healthcheck endpoint configured on port 9999. The container already includes healthcheck instructions.

### Dockerfiles

It shouldn't be necessary to edit any of the Dockerfiles, but there are some important notes about them.

#### Datomic Pro

There is no official Dockerfile for Datomic. This is a really basic implementation using [Amazon's Corretto 17 base Docker image](https://hub.docker.com/_/amazoncorretto) in the Alpine flavor to make it lighter.

#### DynamoDB Local

A custom Dockerfile was created for running DynamoDB Local even though [AWS offers one](https://hub.docker.com/r/amazon/dynamodb-local/). However, I couldn't make it run when using host network, likely because of the built-in `EXPOSE` instruction in the Dockerfile. The custom image should, however, operate the same as Amazon's.

It's based on [Amazon's Corretto 17 base Docker image](https://hub.docker.com/_/amazoncorretto) in the Amazon Linux flavor.