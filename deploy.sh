#!/bin/bash

set -e

cd ..

BASEDIR=$(pwd)

echo "${BASEDIR}"

cd "${BASEDIR}/source/"

rm -rf .DS_Store

git submodule update --remote --merge

hugo -t PaperMod

rsync -avh --exclude "CNAME" --exclude ".git" public/ "${BASEDIR}/master" --delete

cd "${BASEDIR}/master/"

rm -rf .DS_Store

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
