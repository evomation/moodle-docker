#!/bin/bash
set -e

VERSION_FILE=".latest-4.5-version"

# Get latest Moodle 4.5.x tag from the official GitHub repo
LATEST_TAG=$(git ls-remote --tags https://github.com/moodle/moodle.git \
  | grep -o 'refs/tags/v4\.5\.[0-9]*' \
  | sed 's/refs\/tags\///' \
  | sort -V \
  | tail -n1)

echo "Latest Moodle 4.5.x version: $LATEST_TAG"

# If the version hasn't changed, exit early
if [[ -f "$VERSION_FILE" ]] && grep -q "$LATEST_TAG" "$VERSION_FILE"; then
  echo "Version unchanged. No update required."
  exit 0
fi

# Update the version file
echo "$LATEST_TAG" > "$VERSION_FILE"
echo "Updated $VERSION_FILE to $LATEST_TAG"

# Optional: commit the change if inside a git repo
if git rev-parse --is-inside-work-tree &>/dev/null; then
  git add "$VERSION_FILE"
  git commit -m "Update latest Moodle 4.5 version to $LATEST_TAG" || echo "Nothing to commit."
fi

