FROM oraclelinux:8.10

RUN dnf -y update \
&&  dnf -y install python3.12-devel python3.11-devel gcc-toolset-13-gcc-c++ gcc-toolset-13-gcc gcc-toolset-13-libasan-devel make patch \
&& dnf clean all
