localdir = .local

activate:
	echo "#!/bin/bash" > "activate"
	echo ENVDIR=$$(pwd) >> "activate"
	cat ./activate.template >> "activate"

$(localdir)/config_all:
	mkdir -p $(localdir)
	echo BUILDPATH=path_to_your_TCLB_dir > "$(localdir)/config_all"

$(localdir)/tclb_%: $(localdir)/config_all
	singularity build $@ docker://mdzik/$$(echo $@ | sed 's/__/:/g' | sed 's/.*\///g')

$(localdir)/config_%: $(localdir)/config_all 
	echo ". config_all" > $@
	echo SIF=`pwd`"/$$(echo $@ | sed 's/config/tclb/g')" > $@
	echo TCLB_ENV="$$(echo $@ | sed 's/config/tclb/g' | sed 's/.*\///g')"  >> $@
	echo CONFIGUREARGS="\"$(configureargs)\"" >> $@

build_and_configure_$(imname)__$(imtag): 
	export configureargs
	$(MAKE) $(localdir)/tclb_$(imname)__$(imtag)
	$(MAKE) configureargs="$(configureargs)" $(localdir)/config_$(imname)__$(imtag) 


buildkit_gpu: imname = buildkit
buildkit_gpu: imtag = ubuntu_2004_cuda11_latest
buildkit_gpu: configureargs =  --enable-cuda --with-python --with-python-config=python3.8-config --enable-double --enable-keepcode --enable-rinside --enable-cpp11 --with-openmp --with-hdf5 --with-hdf5-lib=//usr/lib/x86_64-linux-gnu/hdf5/openmpi/ --with-hdf5-include=/usr/include/hdf5/openmpi
#buildkit_gpu: build_and_configure_$(imname)__$(imtag)
	

buildkit_cpu: imname = buildkit
buildkit_cpu: imtag = ubuntu_2004_latest
buildkit_cpu: configureargs = --disable-cuda --with-python --with-python-config=python3.8-config --enable-double --enable-keepcode --enable-rinside --enable-cpp11 --with-openmp --with-hdf5 --with-hdf5-lib=//usr/lib/x86_64-linux-gnu/hdf5/openmpi/ --with-hdf5-include=/usr/include/hdf5/openmpi
#buildkit_cpu: build_and_configure_$(imname)__$(imtag)
	

workspace_cpu: imname = workspace
workspace_cpu: imtag = latest
workspace_cpu: configureargs = --disable-cuda --with-python --with-python-config=python3.8-config --enable-double --enable-keepcode --enable-rinside --enable-cpp11 --with-openmp --with-hdf5 --with-hdf5-lib=//usr/lib/x86_64-linux-gnu/hdf5/openmpi/ --with-hdf5-include=/usr/include/hdf5/openmpi
#workspace_cpu: build_and_configure_$(imname)__$(imtag)
	

%_gpu: build_and_configure_$(imname)__$(imtag)	
	ln -fs  config_$(imname)__$(imtag)  $(localdir)/config_$@

%_cpu: build_and_configure_$(imname)__$(imtag)	
	ln -fs  config_$(imname)__$(imtag)  $(localdir)/config_$@
