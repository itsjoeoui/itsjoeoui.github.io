#!/bin/bash

set -e

cd ..

BASEDIR=$(pwd)

echo "${BASEDIR}"

cd "${BASEDIR}/source/"

git submodule update --remote --merge

hugo -t PaperMod

rsync -avh --exclude "CNAME" --exclude ".git" public/ "${BASEDIR}/master" --delete

cd "${BASEDIR}/master/"

git checkout master

git add .

msg="[JoeyCI]: Deploy site $(date)"
if [ -n "$*" ]; then
	msg="$*"
fi
git commit -s -m "$msg"

git push origin master

cd "${BASEDIR}/source/"

git add .

git commit -s -m "[JoeyCI]: Update source"

git push origin source
