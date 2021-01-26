# Builds and setups BTKCore and pyCGM2
# Author: dimitar.stanev@epfl.ch
FROM ubuntu:18.04

# packages should be installed without user's interaction
ENV DEBIAN_FRONTEND=noninteractive

# install dependencies
RUN apt-get update && apt-get -y upgrade --fix-missing
RUN apt-get -y install git cmake swig python3-dev python3-pip
RUN apt-get -y install python3-tk unzip
RUN apt-get install -y x11-apps
RUN pip3 install numpy

# setup timezone (due to some packages)
RUN ln -fs /usr/share/zoneinfo/Europe/Zurich /etc/localtime
RUN dpkg-reconfigure --frontend noninteractive tzdata

# build and install BTKCore
ADD build_btkcore.sh .
RUN chmod +x build_btkcore.sh
RUN ./build_btkcore.sh
ENV BTKCore_DIR=/BTKCore/install
ENV LD_LIBRARY_PATH=$BTKCore_DIR/lib/btk-0.4dev:$LD_LIBRARY_PATH
RUN cd $BTKCore_DIR/python && python3 setup.py install

# build and install pyCGM2
ADD build_pyCGM2.sh .
RUN chmod +x build_pyCGM2.sh
RUN ./build_pyCGM2.sh

# setup user (used for mounting X)
RUN useradd -ms /bin/bash user
ENV DISPLAY :0
USER user

# copy scripts your custom files using ADD
# ADD Batch_run_pyCGM2.tar.xz .