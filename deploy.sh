#!/bin/bash

set -e

cd ..

BASEDIR=$(pwd)

echo "${BASEDIR}"

cd source/

git submodule update --remote --merge

git add .

git commit -s -m "[JoeyCI]: Update source"

git push origin source

hugo -t anatole -d "${BASEDIR}/master/"

cd "${BASEDIR}/master/"

git checkout master

git add .

msg="[JoeyCI]: Deploy site $(date)"
if [ -n "$*" ]; then
	msg="$*"
fi
git commit -s -m "$msg"

git push origin master
