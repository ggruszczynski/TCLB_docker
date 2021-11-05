# TCLB_docker
Docker recipies for TCLB, hosted at https://hub.docker.com/u/mdzik

- cuda in image name indicate GPU support
- core images are not intendet for direct use
- buildkit images should suffice to build full-futered TCLB
- workspace CPU only are intendet for workshops, they include jupyter bindings. See also mdzik/TCLB_binder repo

# Simple use

- install Singularity (https://sylabs.io/guides/3.8/user-guide/quick_start.html#quick-installation-steps)
- clone this repo
```bash
git clone https://github.com/mdzik/TCLB_docker.git
cd TCLB_docker
echo TCLBBUILDPATH=path/to/TCLB > .local/config_all
source activate workspace_cpu
cd $BUILDPATH
scmd ./configure XXXXX
make d2q9
```


## Singularity only
```bash
singularity build tclb.sif docker://mdzik/tclb_buildkit:latest
./tclb.sif
Singularity> git clone https://github.com/CFD-GO/TCLB.git
Singularity> cd TCLB
Singularity> make configure
Singularity> ./configure --with-cuda-arch=sm_30
Singularity> make -j 10 d2q9
Singularity> logout
```

In batch script:
```
mpirun singularity exec --nv tclb.sif TCLB/CLB/d2q9/main file.xml
```
The `--nv` is needed for GPU support


