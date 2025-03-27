#!/bin/bash
VERSION=$(cat .latest-4.5-version)

docker buildx build \
  --platform linux/amd64,linux/arm64 \
  --build-arg MOODLE_TAG=$VERSION \
  -t brandkern/moodle:$VERSION \
  -t brandkern/moodle:4.5-latest \
  --provenance=mode=max \
  --sbom=true \
  --push \
  .

