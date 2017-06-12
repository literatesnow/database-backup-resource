FROM alpine:3.6

RUN apk --no-cache --update add bash jq postgresql findutils

ADD assets/ /opt/resource/
ADD bin/ /opt/resource/

WORKDIR /opt/resource/

RUN chmod +x /opt/resource/in /opt/resource/out /opt/resource/check
