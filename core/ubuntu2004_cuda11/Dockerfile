FROM ubuntu:20.04

ENV LC_ALL=C
ENV PATH=/TCLB:/usr/local/cuda-11.0/bin:$PATH
ENV R_LIBS_USER=/opt/r_libs  
ENV LDFLAGS="-L/usr/lib/x86_64-linux-gnu/hdf5/openmpi/  $LDFLAGS" 
ENV CPPFLAGS="-I /usr/include/hdf5/openmpi $CPPFLAGS"
ENV TSD=/opt/TCLB_STABLE

RUN apt-get -y update
RUN apt-get -y install wget git software-properties-common 
RUN add-apt-repository universe
RUN add-apt-repository multiverse
RUN add-apt-repository restricted
RUN apt-get -y update
RUN apt-get -y install openmpi-bin libopenmpi-dev python-numpy python-dev r-base-dev r-recommended libhdf5-openmpi-dev cmake
RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin
RUN mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600
RUN apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/7fa2af80.pub
RUN add-apt-repository "deb http://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/ /"
RUN apt-get -y update
RUN apt-get -y install cuda-minimal-build-11-0 cuda-command-line-tools-11-0