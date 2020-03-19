#!/bin/bash

function usage {
	echo "generate.Dockerfile architecture [mpi]"
}

if test -z "$1"
then
	usage
	exit -1
fi
ARCH=$1
shift

SYSTEM="ubuntu:18.04"

case $ARCH in
cpu)	BASE="$SYSTEM"
	;;
gpu)	CUDAVER="10.0"
	BASE="nvidia/cuda:$CUDAVER-devel-$(echo $SYSTEM | sed 's/://')"
	;;
list)	echo "cpu gpu"
	exit 0
	;;
*)	echo "Unknown arch"
	usage
	exit -1
	;;
esac	
	
if test -z "$1"
then
	MPITAG=nompi
else
	MPITAG=$1
	shift
fi

case $MPITAG in
openmpi4.0)
	MPITYPE=openmpi
	MPIVER=4.0
	MPIVERSION=4.0.1
	;;
openmpi3.1)
	MPITYPE=openmpi
	MPIVER=3.1
	MPIVERSION=3.1.5
	;;
openmpi3.0)
	MPITYPE=openmpi
	MPIVER=3.0
	MPIVERSION=3.0.5
	;;
nompi)
	MPITYPE=nompi
	;;
list)	echo "openmpi4.0 openmpi3.1 openmpi3.0"
	exit 0
	;;
*)	echo "Unknown mpi: $MPITAG"
	usage
	exit -1
	;;
esac



case $MPITYPE in ######################################

openmpi) ##############################################
cat <<EOF
FROM cfdgo/tclb:$ARCH-nompi

ENV OMPI_VERSION=$MPIVERSION

RUN mkdir -p /tmp/ompi \\
    && cd /tmp/ompi \\
    && wget \\
         -O openmpi-$MPIVERSION.tar.bz2 \\
         https://download.open-mpi.org/release/open-mpi/v$MPIVER/openmpi-$MPIVERSION.tar.bz2 \\
    && tar -xjf openmpi-$MPIVERSION.tar.bz2 \\
    && cd /tmp/ompi/openmpi-$MPIVERSION \\
    && ./configure \\
    && make \\
    && make install

RUN ldconfig
EOF
;; ####################################################

nompi) ################################################
cat <<EOF
FROM $BASE

ENV DOCKER_TAG=$ARCH
ENV CONTAINER=true

ENV LC_ALL=C

RUN apt-get update && apt-get install -y gnupg2

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9 \\
	&& echo "deb http://cran.rstudio.com/bin/linux/ubuntu bionic-cran35/" >>/etc/apt/sources.list \\
	&& apt-get update \\
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \\
		ed \\
		less \\
		locales \\
		vim \\
		wget \\
		ca-certificates \\
		fonts-texgyre \\
		git \\
		software-properties-common \\
		autoconf \\
		ssh \\
		readline-common \\
		joe \\
		r-base-dev \\
		r-recommended \\
		qpdf

RUN R -e "options(repos='http://cran.rstudio.com'); install.packages(c('optparse','numbers', 'yaml'));" \\
	&& wget https://github.com/llaniewski/rtemplate/archive/master.tar.gz -O rtemplate.tar.gz \\
	&& R CMD INSTALL rtemplate.tar.gz \\
	&& wget https://github.com/llaniewski/gvector/archive/master.tar.gz -O gvector.tar.gz \\
	&& R CMD INSTALL gvector.tar.gz \\
	&& wget https://github.com/llaniewski/polyAlgebra/archive/master.tar.gz -O polyAlgebra.tar.gz \\
	&& R CMD INSTALL polyAlgebra.tar.gz

RUN ldconfig

CMD ["bash"]

EOF
;; ####################################################

*)
	echo "Unknown MPITYPE: $MPITYPE --- this should not happen"
	exit -1
	;;
esac ##################################################
exit 0
