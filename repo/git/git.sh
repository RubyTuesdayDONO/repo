#!/bin/bash

GIT_DIR="${HOME}/src/org/rubydono/meta/repo"
export GIT_DIR="${GIT_DIR:-$(readlink -f "$(dirname "${0}")")}"
export GIT_WORK_TREE="${GIT_WORK_TREE:-$(dirname "${0}")}"
export GIT_INDEX_FILE="${GIT_INDEX_FILE:-${GIT_WORK_TREE}/.git/index}"
mkdir -p "$(dirname "${GIT_INDEX_FILE}")"

git $@
