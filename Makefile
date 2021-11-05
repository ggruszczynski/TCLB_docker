localdir = .local

$(localdir)/config_all:
	mkdir -p $(localdir)
	echo BUILDPATH=path_to_your_TCLB_dir > "$(localdir)/config_all"

$(localdir)/tclb_%: $(localdir)/config_all
	singularity build $@ docker://mdzik/$$(echo $@ | sed 's/__/:/g' | sed 's/.*\///g')

$(localdir)/config_%: $(localdir)/config_all 
	echo ". config_all" > $@
	echo SIF=`pwd`"/$$(echo $@ | sed 's/config/tclb/g')" > $@
	echo TCLB_ENV="$$(echo $@ | sed 's/config/tclb/g' | sed 's/.*\///g')"  >> $@

build_and_configure_$(imname)__$(imtag): 
	$(MAKE) $(localdir)/tclb_$(imname)__$(imtag)
	$(MAKE) $(localdir)/config_$(imname)__$(imtag)


buildkit_gpu: imname = buildkit
buildkit_gpu: imtag = ubuntu_2004_cuda11_latest
#buildkit_gpu: build_and_configure_$(imname)__$(imtag)
	

buildkit_cpu: imname = buildkit
buildkit_cpu: imtag = ubuntu_2004_latest
#buildkit_cpu: build_and_configure_$(imname)__$(imtag)
	

workspace_cpu: imname = workspace
workspace_cpu: imtag = latest
#workspace_cpu: build_and_configure_$(imname)__$(imtag)
	

%_gpu: build_and_configure_$(imname)__$(imtag)	
	ln -fs  config_$(imname)__$(imtag)  $(localdir)/config_$@

%_cpu: build_and_configure_$(imname)__$(imtag)	
	ln -fs  config_$(imname)__$(imtag)  $(localdir)/config_$@
