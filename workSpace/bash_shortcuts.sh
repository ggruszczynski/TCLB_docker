#!/bin/bash

#export TCLBBUILDPATH=`cd ~/TCLB && pwd`

function scmd {
	eval $@
}
export -f scmd


# function tclb() {
# 	$TCLBBUILDPATH/CLB/$1/main $2 
# }

# function tclbmpi() {
# 	mpirun $TCLBBUILDPATH/CLB/$1/main $2 
# }

# export -f tclb
# export -f tclbmpi

