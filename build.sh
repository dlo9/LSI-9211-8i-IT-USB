#!/bin/sh

TAG="flasher"
IMG="$TAG.img"

if [ "$1" == "--disable-bios" ]; then
	DISABLE_BIOS=1
fi

# Docker build (with no context)
docker build --build-arg IMG="$IMG" --build-arg DISABLE_BIOS="$DISABLE_BIOS" -t "$TAG" .

# Exfiltrate data
container="$(docker create "$TAG" true)"
docker cp "$container:/$IMG" .
