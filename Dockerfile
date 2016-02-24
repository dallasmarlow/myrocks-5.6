FROM ubuntu
RUN apt-get update && apt-get install -y g++ \
                                         cmake \
                                         libbz2-dev \
                                         libaio-dev \
                                         bison \
                                         zlib1g-dev \
                                         libsnappy-dev \
                                         libgflags-dev \
                                         libreadline6-dev \
                                         libncurses5-dev \
                                         libssl-dev \
                                         liblz4-dev \
                                         gdb \
                                         git

ADD . /usr/local/src/mysql-5.6
WORKDIR /usr/local/src/mysql-5.6

RUN git submodule init && git submodule update
RUN cmake . -DCMAKE_BUILD_TYPE=RelWithDebInfo -DWITH_SSL=system -DWITH_ZLIB=bundled -DMYSQL_MAINTAINER_MODE=0 -DENABLED_LOCAL_INFILE=1 && \
    make -j8 && \
    make install && \
    make clean
