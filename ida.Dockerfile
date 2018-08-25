FROM ubuntu:xenial 
MAINTAINER rui@deniable.org

# check https://hub.docker.com/u/fdiskyou/ for more information
ENV WRKSRC /opt
ENV DEBIAN_FRONTEND noninteractive
ENV DISPLAY :0

RUN export uid=1000 gid=1000 && \
  mkdir -p /home/idauser && \
  echo "idauser:x:${uid}:${gid}:Developer,,,:/home/idauser:/bin/bash" >> /etc/passwd && \
  echo "idauser:x:${uid}:" >> /etc/group && \
  echo "idauser ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/idauser && \
  chmod 0440 /etc/sudoers.d/idauser && \
  chown ${uid}:${gid} -R /home/idauser

RUN dpkg --add-architecture i386 && \
apt-get update && apt-get -y upgrade && \
apt-get -y install git cmake libelf-dev libelf1 libiberty-dev libboost-all-dev libtool pkg-config python-dev lzma \
  lzma-dev sudo liblzma-dev liblz-dev liblz1 autoconf gdb htop nasm binwalk binutils strace ltrace unzip libtool-bin \
  screen python3-dev python-pip python3-pip radare2 radare2-plugins wget libc6:i386 libncurses5:i386 libstdc++6:i386 \
  libc6-dev-i386 libini-config-dev \
  libxext6:i386 libxrender1:i386 libglib2.0-0:i386 libfontconfig1:i386 libsm6:i386 libfreetype6:i386 libglib2.0-0:i386 && \
apt-get -qy clean autoremove && \
rm -rf /var/lib/apt/lists/*

USER idauser
ENV HOME /home/idauser
CMD ["/bin/bash"]
