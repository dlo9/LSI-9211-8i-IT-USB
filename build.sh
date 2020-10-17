#!/bin/sh

TAG="flasher"
IMG="$TAG.img"

# Docker build (with no context)
docker build --build-arg IMG="$IMG" -t "$TAG" .

# Exfiltrate data
container="$(docker create "$TAG" true)"
docker cp "$container:/$IMG" .
