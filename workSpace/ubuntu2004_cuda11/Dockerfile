FROM mdzik/tclb_docker:buildKit_ubuntu2004_cuda11


RUN apt-get install -y curl 
RUN curl -sL https://deb.nodesource.com/setup_12.x |  bash -

RUN apt-get install -y pip nodejs

#RUN npm install -g pvw-visualizer

#RUN apt-get install git cmake build-essential libgl1-mesa-dev libxt-dev  python3-dev python3-numpy libopenmpi-dev libtbb-dev ninja-build

#RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && bash Miniconda3-latest-Linux-x86_64.sh -b -p /opt/miniconda && rm Miniconda3-latest-Linux-x86_64.sh

#RUN  . /opt/miniconda/bin/activate && conda update -n base -c defaults conda

#RUN  . /opt/miniconda/bin/activate && conda install xeus -c conda-forge

#RUN  . /opt/miniconda//bin/activate && conda install jupyterlab -c conda-forge

#RUN  . /opt/miniconda//bin/activate && conda install numpy sympy pandas matplotlib h5py -c conda-forge

#RUN find /opt/miniconda -type d -exec chmod o+rwx {} \;

#RUN find /opt/miniconda -type f -exec chmod o+rw {} \;

#RUN find /opt/miniconda/bin -type f -exec chmod o+x {} \;

RUN pip install numpy sympy pandas matplotlib h5py jupyterlab 

RUN mkdir /opt/paraview && cd /opt/paraview && wget 'https://www.paraview.org/paraview-downloads/download.php?submit=Download&version=v5.9&type=binary&os=Linux&downloadFile=ParaView-5.9.1-osmesa-MPI-Linux-Python3.8-64bit.tar.gz' -O  ParaView-5.9.1-osmesa-MPI-Linux-Python3.8-64bit.tar.gz  && tar -zxf ParaView-5.9.1-osmesa-MPI-Linux-Python3.8-64bit.tar.gz && rm ParaView-5.9.1-osmesa-MPI-Linux-Python3.8-64bit.tar.gz

RUN apt-get install -y python3-venv

RUN python3 -m venv /opt/paraview/venv
RUN pip install virtualenv
RUN virtualenv /opt/paraview/venv

RUN cd /tmp && git clone https://github.com/Kitware/visualizer.git && cd visualizer && npm update && npm  install && npm run build && npm link

#RUN pip install pvlink nodejs
#RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager 
#RUN jupyter labextension install pvlink
