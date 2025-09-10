# PostgreSQL Client Docker Image

This repository contains a Dockerfile to build a lightweight Alpine Linux-based Docker image with PostgreSQL client tools and curl.

## Docker Image

The Docker image is automatically built and published to Docker Hub at: **[jnovent/postgres-client](https://hub.docker.com/r/jnovent/postgres-client)**

### What's included:
- Alpine Linux (latest)
- PostgreSQL client (`postgresql-client`)
- curl

## Automated Builds

The Docker image is automatically rebuilt every Monday morning at 8:00 AM UTC using GitHub Actions.

### Manual Build

To build the image locally:

```bash
docker build -t postgres-client .
```

### Usage

```bash
# Pull and run the latest image
docker pull jnovent/postgres-client:latest
docker run -it jnovent/postgres-client:latest /bin/sh

# Use PostgreSQL client tools
docker run -it jnovent/postgres-client:latest psql --help
```
