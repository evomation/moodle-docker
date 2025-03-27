VERSION=$(cat .latest-4.5-version)

docker buildx build \
  --platform linux/amd64 \
  --build-arg MOODLE_TAG=$VERSION \
  --load \
  -t brandkern/moodle:$VERSION \
  -t brandkern/moodle:4.5-latest \
  .

