#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
image=localhost:5000/cloudnotes:1.0.0
docker compose -p cloudnotes-practice-registry -f registry.yaml up -d
for attempt in {1..30}; do
  if curl -fsS http://localhost:5000/v2/ >/dev/null; then break; fi
  sleep 1
done
curl -fsS http://localhost:5000/v2/ >/dev/null
docker tag cloudnotes:1.0.0 "$image"
docker push "$image"
# Remove registry-qualified reference so next command explicitly retrieves it.
# Local cloudnotes:1.0.0 may still share cached layers; this is not a cold download.
docker image rm "$image"
docker pull "$image"
docker image inspect "$image" --format 'Published/pulled: {{index .RepoTags 0}} digest={{index .RepoDigests 0}}'
