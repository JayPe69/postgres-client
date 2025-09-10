FROM alpine
RUN apk update --no-cache && apk upgrade --no-cache && \
    apk --no-cache add postgresql-client curl
CMD [ "" ]