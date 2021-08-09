FROM ubuntu:20.04

ENV LC_ALL=C
ENV PATH=/TCLB:/usr/local/cuda-11.0/bin:$PATH
ENV R_LIBS_USER=/opt/r_libs  
ENV LDFLAGS="-L/usr/lib/x86_64-linux-gnu/hdf5/openmpi/  $LDFLAGS" 
ENV CPPFLAGS="-I /usr/include/hdf5/openmpi $CPPFLAGS"
ENV TSD=/opt/TCLB_STABLE

ENV TZ=Europe/Warsaw
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get -y update
RUN apt-get -y install wget git software-properties-common 
RUN add-apt-repository universe
RUN add-apt-repository multiverse
RUN add-apt-repository restricted
RUN apt-get -y update
RUN apt-get -y install openmpi-bin libopenmpi-dev python-numpy python-dev r-base-dev r-recommended libhdf5-openmpi-dev cmake