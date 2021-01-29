FROM golang:1.10-alpine3.8 AS multistage

RUN apk add --no-cache git=2.25.1

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
