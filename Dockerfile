#FROM alpine:3.18.5
FROM ubuntu

WORKDIR /home/

# Replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Set debconf to run non-interactively
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
SHELL ["/bin/bash", "--login", "-c"]
RUN apt-get update && \
        apt-get install wget git gcc python3 xz-utils python3-neovim -y && \
        #wget https://nodejs.org/dist/v20.10.0/node-v20.10.0-linux-x64.tar.xz && \
        wget https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz && \
        tar -xf nvim-linux64.tar.gz && \
        rm nvim-linux64.tar.gz && \
        #tar -xf node-v20.10.0-linux-x64.tar.xz && \
        #rm node-v20.10.0-linux-x64.tar.xz && \
        #mv /home/node-v20.10.0-linux-x64/bin/* /usr/local/bin/ && \
        wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
        #&& \
        #nvm install 20.10.0
ENV NVM_DIR /root/.nvm
ENV NODE_VERSION 20.10.0

# RUN . /root/.bashrc
#RUN nvm install --no-progress 20.10.0
RUN . $NVM_DIR/nvm.sh && \
        nvm install 20.10.0 \
    && nvm alias default $NODE_VERSION \
    && nvm use default
#RUN echo "export PATH=\"/home/node-v20.10.0-linux-x64/bin:\$PATH\"" >> /root/.bashrc

# COPY init.lua /root/.config/nvim/init.lua

WORKDIR /tmp

#CMD ["/bin/bash", "/home/nvim-linux64/bin/nvim"]
#CMD ["bash", "/home/nvim-linux64/bin/nvim"]
CMD ["bash"]
