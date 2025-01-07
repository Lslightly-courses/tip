# You may need to set proxy
# docker build -t lslightly2357/tipc --network=host .
FROM docker.io/library/ubuntu:22.04
LABEL maintainer="molepi40@gmail.com,lqw332664203@mail.ustc.edu.cn"
RUN sed -i s@/archive.ubuntu.com/@/mirrors.ustc.edu.cn/@g /etc/apt/sources.list \ 
    && sed -i s@/security.ubuntu.com/@/mirrors.ustc.edu.cn/@g /etc/apt/sources.list
RUN export DEBIAN_FRONTEND=noninteractive && apt-get update && apt-get install -y \
    curl wget git vim gcc g++ gpg sudo lsb-release software-properties-common gnupg gdb python3-pip catch2 cmake
RUN pip3 install pytest
WORKDIR /tip    

# download llvm
RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -
RUN echo "deb https://mirrors.tuna.tsinghua.edu.cn/llvm-apt/jammy/ llvm-toolchain-jammy main" > /etc/apt/sources.list.d/llvm-apt.list
RUN sudo apt update
RUN sudo apt -y install \
        libllvm-14-ocaml-dev \
        libllvm14 \
        llvm-14 \
        llvm-14-dev \
        llvm-14-doc \
        llvm-14-examples \
        llvm-14-runtime 
RUN sudo apt -y install \
        clang-tools-14 \
        clang-14-doc \
        libclang-common-14-dev \
        libclang-14-dev \
        libclang1-14 \
        clang-format-14 \
        python3-clang-14 \
        graphviz \
        jq \
        doxygen
    
RUN git clone https://github.com/Lslightly/tipc.git
RUN cd ./tipc && \
    ./bin/bootstrap.sh && \
    . ~/.bashrc
WORKDIR /tip/tipc
RUN mkdir build && \
    cd build && \
    cmake .. && \
    make -j6


# RUN git clone https://github.com/ustc-pldpa/tipc-passes.git && \
COPY tipc-passes /tip/tipc-passes

WORKDIR /tip/tipc-passes
RUN mkdir build && \
    cd build && \
    cmake .. && \
    make -j6

CMD [ "/bin/bash" ]
