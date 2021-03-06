FROM golang:1.10-alpine3.8 AS builder
# hadolint ignore=DL3018
RUN apk add --no-cache --update git
WORKDIR /go/src/api
COPY . .

RUN go get -d -v \
  && go install -v \
  && go build


FROM alpine:3.8
COPY --from=builder /go/bin/api /go/bin/
EXPOSE 8080
CMD ["/go/bin/api"]







