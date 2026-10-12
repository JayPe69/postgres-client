FROM alpine
ARG PG_VERSION=17
RUN apk update --no-cache && apk upgrade --no-cache && \
    apk --no-cache add postgresql${PG_VERSION}-client curl
CMD [ "" ]