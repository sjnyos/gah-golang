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
COPY --from=multistage /go/bin/api .
EXPOSE 3000
#RUN chmod +x /go/bin/go-api
CMD ["./go-api"]







