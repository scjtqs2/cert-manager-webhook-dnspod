#!/bin/bash
#docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
docker buildx create --use --name mydevbuilder
docker buildx build --tag scjtqs/cert-manager-webhook-dnspod:1.4.3 --platform linux/amd64,linux/arm64 --push .
docker buildx rm mydevbuilder