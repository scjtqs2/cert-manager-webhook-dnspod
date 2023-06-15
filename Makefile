#IMAGE_NAME := "cr.imroc.cc/library/cert-manager-webhook-dnspod"
IMAGE_NAME := "scjtqs/cert-manager-webhook-dnspod"
IMAGE_TAG := "latest"

build:
	docker buildx create --use --name mydnspod
	docker buildx build --platform linux/amd64,linux/arm64 -t "$(IMAGE_NAME):$(IMAGE_TAG)" --push .
	docker buildx rm mydnspod

build_fast:
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o ./bin/webhook -ldflags '-w -extldflags "-static"' .
	docker buildx build --push --platform=linux/amd64 -f fast.Dockerfile -t "$(IMAGE_NAME):$(IMAGE_TAG)" .
	rm ./bin/webhook
