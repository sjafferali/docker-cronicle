#!/bin/bash

VERSION=$(cat version)
URL="https://api.github.com/repos/jhuckaby/Cronicle/tarball/${VERSION}"

wget -O package.tar.gz "$URL"

