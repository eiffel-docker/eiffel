FROM debian:latest
MAINTAINER Jocelyn Fiat

RUN apt-get update 
RUN apt-get -y install curl bzip2 make gcc subversion git-all

RUN curl -L -sS https://ftp.eiffel.com/pub/beta/15.11/Eiffel_15.11_gpl_98046-linux-x86-64.tar.bz2 | tar xj -C /usr/local

# Define Eiffel environment variables
ENV ISE_EIFFEL /usr/local/Eiffel_15.11
ENV ISE_PLATFORM linux-x86-64
ENV EIFFEL_SRC /home/eiffel/trunk/Src
ENV ISE_LIBRARY $EIFFEL_SRC
ENV EIFFEL_LIBRARY /eiffel
ENV PATH $PATH:$ISE_EIFFEL/studio/spec/$ISE_PLATFORM/bin:$ISE_EIFFEL/tools/spec/$ISE_PLATFORM/bin:$ISE_EIFFEL/library/gobo/spec/$ISE_PLATFORM/bin

RUN apt-get install -y libxtst-dev libgtk2.0-dev

RUN export uid=1000 gid=1000 && \
    mkdir -p /home/eiffel && \
    echo "eiffel:x:${uid}:${gid}:eiffel,,,:/home/eiffel:/bin/bash" >> /etc/passwd && \
    echo "eiffel:x:${uid}:" >> /etc/group && \
    chown ${uid}:${gid} -R /home/eiffel

USER eiffel
ENV HOME /home/eiffel
RUN mkdir -p /home/eiffel/trunk
WORKDIR /home/eiffel/trunk
RUN svn checkout https://svn.eiffel.com/eiffelstudio/trunk/Src Src
WORKDIR /home/eiffel/trunk/Src
CMD geant prepare
WORKDIR /home/eiffel
CMD xterm
