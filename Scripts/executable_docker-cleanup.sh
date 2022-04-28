#!/bin/sh
echo "Cleanup docker images"
docker image prune -a --force --filter "until=240h"
docker image prune -a --force --filter="label=deprecated"
echo "Cleanuped docker images"
