#!/usr/bin/env bash

# build pyCMG2

set -xeuo pipefail

try_clone_checkout() {
    url="${1}"
    ref="${2}"

    dir=$(basename "${url}" | sed 's/.git$//')

    echo "${0}: ${dir}: must be built from source for Linux builds"
    if [ ! -d "${dir}" ]; then
        git clone "${url}"
        cd "${dir}"
        git checkout "${ref}"
        cd -
    else
        echo "${0}: ${dir}: already exists: skipping clone"
    fi
}

try_clone_checkout "https://github.com/mitkof6/pyCGM2.git" "dev-py37-64"

cd pyCGM2
pip3 install -e .
