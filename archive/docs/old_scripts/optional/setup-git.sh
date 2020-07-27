#!/bin/bash

set -e

if [[ $# -eq 0 ]] ; then
  echo "-------------------------------------"
  echo "Please supply a github user name"
  echo "-------------------------------------"
  exit 1
fi

NAME=$1

git config --global user.name ${NAME}
git config --global user.email ${NAME}@users.noreply.github.com
git config --global push.default simple
#git config --global core.ignorecase false

echo ""
echo "*** $0 Done ***"
echo ""
