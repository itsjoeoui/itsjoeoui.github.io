#!/bin/bash

set -e

cd ..

BASEDIR=$(pwd)

echo "${BASEDIR}"

cd source/

hugo -t anatole -d "${BASEDIR}/master/"

cd "${BASEDIR}/master/"

git checkout master

git add .

msg="[JoeouiCI]: Deploy site $(date)"
if [ -n "$*" ]; then
	msg="$*"
fi
git commit -m "$msg"

git push origin master

cd "${BASEDIR}/source/"