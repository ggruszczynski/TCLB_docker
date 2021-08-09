# TCLB_docker
Docker recipies for TCLB

## Singularity
```
singularity build tclb.sif docker://mdzik/tclb_docker:buildkit_ubuntu2004_cuda11
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
