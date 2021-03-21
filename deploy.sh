#!/bin/bash

set -e

cd ..

BASEDIR=$(pwd)

echo "${BASEDIR}"

cd source/

git submodule update --remote --merge

hugo -t PaperMod -d "${BASEDIR}/master/"

git add .

git commit -s -m "[JoeyCI]: Update source"

git push origin source

cd "${BASEDIR}/master/"

git checkout master

git add .

msg="[JoeyCI]: Deploy site $(date)"
if [ -n "$*" ]; then
	msg="$*"
fi
git commit -s -m "$msg"

git push origin master
