FROM mdzik/tclb_docker:core_ubuntu2004

ENV LC_ALL=C
ENV PATH=/TCLB:/usr/local/cuda-11.0/bin:$PATH
ENV R_LIBS_USER=/opt/r_libs  
ENV LDFLAGS="-L/usr/lib/x86_64-linux-gnu/hdf5/openmpi/  $LDFLAGS" 
ENV CPPFLAGS="-I /usr/include/hdf5/openmpi $CPPFLAGS"
ENV TSD=/opt/TCLB_STABLE
ENV ADIOS_PATH=/opt/ADIOS


RUN apt-get -y update
RUN apt-get -y install cmake
RUN cd /opt && wget https://raw.githubusercontent.com/CFD-GO/TCLB/master/tools/install.sh && chmod +x /opt/install.sh
RUN mkdir /opt/r_libs

RUN R_LIBS_USER=/opt/r_libs /opt/install.sh rdep
RUN R_LIBS_USER=/opt/r_libs /opt/install.sh rinside
RUN R_LIBS_USER=/opt/r_libs /opt/install.sh rpython

RUN R_LIBS_USER=/opt/r_libs R --slave << "\\
		options(repos='http://cran.rstudio.com'); \\
		p = Sys.getenv('R_LIBS_USER');\\
		if ( (p != '') && (!file.exists(p)) ) {\\
			dir.create(p,recursive=TRUE);\\
			.libPaths(p);\\
		}\\
		install.packages('jsonlite', method='wget');"

RUN cd /tmp && git clone https://github.com/ornladios/ADIOS2.git ADIOS2 
RUN mkdir /tmp/build && cd /tmp/build && cmake -DCMAKE_INSTALL_PREFIX=/opt/ADIOS2 -DBUILD_TESTING=OFF -DADIOS2_BUILD_EXAMPLES=OFF /tmp/ADIOS2 && make 

RUN R_LIBS_USER=/opt/r_libs echo "options(repos='http://cran.rstudio.com'); p = Sys.getenv('R_LIBS_USER'); install.packages('jsonlite', method='wget');" | R --slave