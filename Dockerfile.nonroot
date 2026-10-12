FROM alpine
ARG PG_VERSION=17
RUN apk update --no-cache && apk upgrade --no-cache && \
    apk --no-cache add postgresql${PG_VERSION}-client curl && \
    addgroup -g 1000 -S postgres-client && \
    adduser -u 1000 -S -G postgres-client -h /home/postgres-client postgres-client
USER postgres-client
WORKDIR /home/postgres-client
CMD [ "" ]
