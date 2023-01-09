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
    npm \
    curl \
    libcairo2
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - &&\
    apt-get install -y nodejs 

RUN python3 -m pip install --upgrade pip

RUN    pip3 install \
    setuptools>=41.0.0 \
    scipy>=1.4.1 \
    wheel \
    networkx>=2.0 \
    traits==4.6.0 \
    nipy==0.4.2 \
    nipype==1.1.9 \
    matplotlib==3.1.1 \
    jupyter \
    jupyterlab \
    pymc3==3.7 \ 
    theano==1.0.4 \
    graphviz==0.13 \
    arviz==0.4.1 \
    neurocombat-sklearn==0.1.3 \
    sklearn-pandas==1.8.0 \
    seaborn==0.10.0 \
    Pillow==7.2.0 \
    tensorflow==2.3.0\
    statsmodels

RUN pip3 install \
    autopep8==1.6.0 \
    certifi==2021.10.8 \
    charset-normalizer==2.0.7 \
    click==8.0.3 \
    et-xmlfile==1.1.0 \
    Flask==2.0.2 \
    idna==3.3 \
    itsdangerous==2.0.1 \
    Jinja2==3.0.2 \
    MarkupSafe==2.0.1 \
    numpy>=1.19.5 \
    openai\
    openpyxl==3.0.9 \
    pycodestyle==2.8.0 \
    python-dateutil==2.8.2 \
    python-dotenv==0.19.2 \
    pytz==2021.3 \
    requests==2.26.0 \
    six==1.16.0 \
    toml==0.10.2 \
    tqdm==4.62.3 \
    urllib3==1.26.7 \
    Werkzeug==2.0.2 \
    drawSvg\
    && jupyter labextension install @axlair/jupyterlab_vim \
    && rm -rf /var/lib/apt/lists/* 

RUN wget -O- http://neuro.debian.net/lists/bionic.us-nh.full | \
    tee /etc/apt/sources.list.d/neurodebian.sources.list && \ 
    apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 2649A5A9 \ 
    && rm -rf /var/lib/apt/lists/* 

RUN apt-get update && apt-get install --no-install-recommends -y\
    fsl-5.0-core=5.0.9*\
    fsl-atlases\
    libglib2.0-0\
    libsm6\
    ants\
    libxt6\
    libjpeg62\
    libglu1-mesa

EXPOSE 8888
RUN mkdir /.local && chmod -R 777 /.local &&\
    mkdir /.jupyter  &&\
    mkdir /.theano && chmod -R 777 /.theano 

COPY ./bash.bashrc /etc/bash.bashrc
COPY ./.jupyter /.jupyter
RUN chmod -R 777 /.jupyter
COPY . /app

# Command to run at startup
# run with: 
# docker run -it --user=$UID:$UID -p 8888:8888 -v $(pwd):/data <container_name>
# Tip: Set up a bashrc function:
# function JLAB { docker run -it --user=$UID:$UID -p 8888:8888 -v $(pwd):/data <container_name>; }
WORKDIR /data
ENTRYPOINT ["/bin/bash", "/app/startup.sh"]
CMD [""]


