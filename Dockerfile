FROM golang:1.23rc2-alpine3.20 as builder
WORKDIR /src/cmd/web

COPY . .


#WORKDIR /go/src/gitlab.com/idoko/bucketeer
#
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o oidc example/server/main.go

RUN ls -ltr

FROM alpine
RUN apk add --no-cache ca-certificates && update-ca-certificates
COPY --from=builder /src/cmd/web/oidc /usr/bin/oidc
EXPOSE 9998
ENTRYPOINT ["/usr/bin/oidc"]
