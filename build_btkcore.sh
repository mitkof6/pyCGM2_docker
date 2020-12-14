#!/usr/bin/env bash

# build BTKCore from source

set -xeuo pipefail

# install dependencies in case they are missing
# sudo apt-get -y install git cmake swig python3-dev python3-pip
# pip3 install numpy --user

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

try_clone_checkout "https://github.com/mitkof6/BTKCore" "btk_python_setup"

cd BTKCore
mkdir build
cd build

cmake .. \
      -DCMAKE_INSTALL_PREFIX="../install" \
      -DBTK_WRAP_PYTHON="ON" \
      -DBUILD_SHARED_LIBS="ON"

make -j$(nproc)
make install
