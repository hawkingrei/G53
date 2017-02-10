FROM golang:1.7.5-alpine3.5
RUN apk add --no-cache ca-certificates
RUN set -ex \
	&& apk add --no-cache --virtual .build-deps \
		git make 

RUN go get -v github.com/tools/godep
RUN go get -d -v github.com/hawkingrei/g53
RUN cd ${GOPATH}/src/github.com/hawkingrei/g53 && godep restore && make all
EXPOSE 80
EXPOSE 53/udp
ENTRYPOINT ["G53","--verbose"]

