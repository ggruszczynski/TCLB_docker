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
```
now you need to set path to your TCLB clone repo (cloned fork probably)
```
make clean
make activate
editor .local/config_all

```
and you are good to go
```
source /path/to/TCLB_docker/activate workspace_cpu
cd $TCLB_PATH
scmd ./configure $CONFIGUREARGS 
tclbmake d2q9
tclb d2q9 ./examples/flow/karman.xml
```
- Keep in mind that Singularity will include in your env directories below  PWD, not necessary home.
- Jupyter Lab will do the same, so `cd` before `scmd`/`jupyterlab`
