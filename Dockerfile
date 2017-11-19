FROM ubuntu:17.04

MAINTAINER Vijay Sharma <ivnyou.all@gmail.com>

USER root

# Some Basic Environment Variables
ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV TERM screen

# Ubuntu software that might be needed (latex, pandoc, sage, jupyter)
RUN \
     apt-get update \
  && apt-get install -y \
       software-properties-common \
       texlive \
       texlive-latex-extra \
       texlive-xetex \
       tmux \
       flex \
       bison \
       libreadline-dev \
       htop \
       screen \
       pandoc \
       aspell \
       poppler-utils \
       net-tools \
       wget \
       git \
       python \
       python-pip \
       make \
       g++ \
       sudo \
       psmisc \
       haproxy \
       nginx \
       vim \
       bup \
       inetutils-ping \
       lynx \
       telnet \
       git \
       emacs \
       subversion \
       ssh \
       m4 \
       latexmk \
       libpq5 \
       libpq-dev \
       build-essential \
       gfortran \
       automake \
       dpkg-dev \
       libssl-dev \
       imagemagick \
       libcairo2-dev \
       libcurl4-openssl-dev \
       graphviz \
       smem \
       python3-yaml \
       locales \
       locales-all

# Jupyter from pip (since apt-get jupyter is ancient)
RUN \
  pip install "ipython<6" jupyter

# Which commit to checkout and build.
ARG commit=HEAD

# Actual HOL project code and TensorFlow library
RUN \
  pip install Wand \
  pip install scipy \
  pip install matplotlib \
  pip install pymatbridge \
  pip install scikit-learn \
  pip install keras \
  pip install --upgrade https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-1.0.1-cp27-none-linux_x86_64.whl

# Skipping below build for tensorflow for manually installed TensorFlow above
# RUN cd /tensorflow \
#    ./configure

# Building HOL-Theorem prover library
RUN cd /deepmath/hoo \
    basel build ...
    
# Starting Ipython notebook    
CMD jupyter notebook --ip=0.0.0.0 --port=8080 --no-browser

EXPOSE 80 8080
