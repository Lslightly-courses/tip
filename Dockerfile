# docker build -t lslightly2357/tipc --network=host .
FROM docker.io/library/ubuntu:22.04
LABEL maintainer="molepi40@gmail.com,lqw332664203@mail.ustc.edu.cn"
RUN sed -i s@/archive.ubuntu.com/@/mirrors.ustc.edu.cn/@g /etc/apt/sources.list \ 
    && sed -i s@/security.ubuntu.com/@/mirrors.ustc.edu.cn/@g /etc/apt/sources.list
RUN export DEBIAN_FRONTEND=noninteractive && apt-get update && apt-get install -y \
    curl wget git vim gcc g++ gpg sudo lsb-release software-properties-common gnupg gdb python3-pip catch2
RUN pip3 install pytest
WORKDIR /tip    
RUN git clone https://github.com/ustc-pldpa/tipc.git && \
    cd ./tipc && \
    ./bin/bootstrap.sh && \
    . ~/.bashrc && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make -j6 && \ 
    cd ../..


# RUN git clone https://github.com/ustc-pldpa/tipc-passes.git && \
COPY tipc-passes /tip/tipc-passes

RUN cd tipc-passes && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make

CMD [ "/bin/bash" ]
