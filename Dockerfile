FROM golang:1.19-alpine3.15 AS build

ADD . /workspace

WORKDIR /workspace
ENV GO111MODULE=on
ENV GOPROXY=http://goproxy.cn

RUN go mod tidy


RUN CGO_ENABLED=0 go build -o webhook -ldflags '-s -w -extldflags "-static"' .

FROM alpine:3.15

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories

RUN apk add --no-cache ca-certificates

COPY --from=build /workspace/webhook /usr/local/bin/webhook

ENTRYPOINT ["/usr/local/bin/webhook"]
