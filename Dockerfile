FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

#Base configuration for neurodebian
RUN apt-get update && apt-get install -y\
    wget\
    gnupg\ 
    python3=3.6.7*\
    python3-pip\
    python3-tk=3.6.9*\
    ants=2.2.0*\
    graphviz=2.40.1*\
    liblapack-dev \
    gfortran \
    nodejs \ 
    npm \
# pip
    && pip3 install \
    wheel \
    numpy==1.17.0 \
    networkx==1.11 \
    traits==4.6.0 \
    nipy==0.4.2 \
    nipype==1.1.9 \
    matplotlib==3.1.1 \
    jupyter==1.0.0 \
    jupyterlab==0.33.12 \
    pymc3==3.7 \ 
    theano==1.0.4 \
    graphviz==0.13 \
    arviz==0.4.1 \
    neurocombat-sklearn==0.1.3 \
    sklearn-pandas==1.8.0 \
    seaborn==0.10.0 \
    Pillow==7.2.0 \
    && jupyter labextension install jupyterlab_vim \
    && rm -rf /var/lib/apt/lists/* 

EXPOSE 8888
RUN mkdir /.local && chmod -R 777 /.local &&\
    mkdir /.jupyter && chmod -R 777 /.jupyter &&\
    mkdir /.theano && chmod -R 777 /.theano


COPY ./.jupyter /.jupyter
COPY . /app

# Command to run at startup
# run with: 
# docker run -it --user=$UID:$UID -p 8888:8888 -v $(pwd):/data <container_name>
# Tip: Set up a bashrc function:
# function JLAB { docker run -it --user=$UID:$UID -p 8888:8888 -v $(pwd):/data <container_name>; }
WORKDIR /data
ENTRYPOINT ["/bin/bash", "/app/startup.sh"]
CMD [""]


