#!/usr/bin/env bash

docker build -t grecycubesgav/slackbuild-tpm2-tss:latest .
docker create --name temp_container grecycubesgav/slackbuild-tpm2-tss:latest
mkdir -p packages
docker cp temp_container:/tmp/tpm2-tss-4.0.1-x86_64-GG_GG.tgz ./packages/
docker rm temp_container
md5sum ./packages/*.*
