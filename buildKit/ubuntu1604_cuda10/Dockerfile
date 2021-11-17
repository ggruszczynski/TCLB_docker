FROM mdzik/tclb_core:ubuntu1604_cuda10_latest

ENV LC_ALL=C
ENV PATH=/TCLB:/usr/local/cuda-11.0/bin:$PATH
ENV R_LIBS_USER=/opt/r_libs  
ENV LDFLAGS="-L/usr/lib/x86_64-linux-gnu/hdf5/openmpi/  $LDFLAGS" 
ENV CPPFLAGS="-I /usr/include/hdf5/openmpi $CPPFLAGS"
ENV TSD=/opt/TCLB_STABLE
ENV ADIOS_PATH=/opt/ADIOS

#https://apt.kitware.com/
RUN apt-get -y install apt-transport-https ca-certificates gnupg software-properties-common wget
RUN wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | tee /etc/apt/trusted.gpg.d/kitware.gpg >/dev/null
RUN apt-add-repository 'deb https://apt.kitware.com/ubuntu/ xenial main'
RUN apt-get -y update
RUN apt-get -y install cmake freeglut3-dev


RUN cd /opt && git clone https://github.com/mdzik/TCLB_singularity
RUN mkdir /opt/r_libs
RUN R_LIBS_USER=/opt/r_libs /opt/TCLB_singularity/install.sh rdep
RUN R_LIBS_USER=/opt/r_libs /opt/TCLB_singularity/install.sh rinside
RUN cd /tmp && git clone https://github.com/ornladios/ADIOS2.git ADIOS2 
RUN mkdir /tmp/build && cd /tmp/build && cmake -DCMAKE_INSTALL_PREFIX=/opt/ADIOS2 -DADIOS2_BUILD_TESTING=Off -DADIOS2_BUILD_EXAMPLES=Off /tmp/ADIOS2 && make 
