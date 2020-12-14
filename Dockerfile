# Builds and setups BTKCore and pyCGM2
# Author: dimitar.stanev@epfl.ch
FROM ubuntu:18.04

# install dependencies
RUN apt-get update
RUN apt-get -y install git cmake swig python3-dev python3-pip
RUN pip3 install numpy --user

# build and install BTKCore
ADD build_btkcore.sh .
RUN chmod +x build_btkcore.sh
RUN ./build_btkcore.sh
ENV BTKCore_DIR=/BTKCore/install
ENV LD_LIBRARY_PATH=$BTKCore_DIR/lib/btk-0.4dev:$LD_LIBRARY_PATH
RUN cd $BTKCore_DIR/python && python3 setup.py install --user

# build and install pyCGM2
ADD build_pyCGM2.sh .
RUN chmod +x build_pyCGM2.sh
RUN ./build_pyCGM2.sh
