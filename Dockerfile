FROM golang:1.10-alpine3.8 AS multistage

# hadolint ignore=DL3018
RUN apk add --no-cache --update git

WORKDIR /go/src/api
COPY . .

RUN go get -d -v \
  && go install -v \
  && go build -o go-api

##

FROM alpine:3.8
COPY --from=multistage /go/bin/api /go/bin/
EXPOSE 3000
CMD ["/go/bin/go-api"]







