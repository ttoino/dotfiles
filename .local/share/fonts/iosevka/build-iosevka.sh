#!/usr/bin/bash
docker run -it -v "$PWD":/build iosevka_build

cp -r dist/iosevka-custom/ttf .
rm -rf dist
