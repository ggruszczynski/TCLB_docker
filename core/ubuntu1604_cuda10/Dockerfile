FROM ubuntu:16.04

ENV LC_ALL=C
ENV PATH=/TCLB:/usr/local/cuda-10.0/bin:$PATH
ENV R_LIBS_USER=/opt/r_libs  
ENV LDFLAGS="-L/usr/lib/x86_64-linux-gnu/hdf5/openmpi/  $LDFLAGS" 
ENV CPPFLAGS="-I /usr/include/hdf5/openmpi $CPPFLAGS"
ENV TSD=/opt/TCLB_STABLE

RUN apt-get -y update
RUN apt-get -y install wget git software-properties-common openmpi-bin libopenmpi-dev python-numpy python-dev r-base-dev r-recommended libhdf5-openmpi-dev
RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-ubuntu1604.pin
RUN mv cuda-ubuntu1604.pin /etc/apt/preferences.d/cuda-repository-pin-600
RUN apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub
RUN add-apt-repository "deb http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/ /"
RUN apt-get -y update
RUN apt-get -y install cuda-minimal-build-10-0 cuda-command-line-tools-10-0