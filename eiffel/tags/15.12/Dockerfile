FROM debian:latest
MAINTAINER Jocelyn Fiat

RUN apt-get update && apt-get -y install curl bzip2 make gcc
RUN curl -L https://ftp.eiffel.com/pub/beta/15.12/Eiffel_15.12_gpl_98497-linux-x86-64.tar.bz2 | tar xj -C /usr/local

# Define Eiffel environment variables
ENV ISE_EIFFEL /usr/local/Eiffel_15.12
ENV ISE_PLATFORM linux-x86-64
ENV ISE_LIBRARY $ISE_EIFFEL
ENV PATH $PATH:$ISE_EIFFEL/studio/spec/$ISE_PLATFORM/bin:$ISE_EIFFEL/tools/spec/$ISE_PLATFORM/bin:$ISE_EIFFEL/library/gobo/spec/$ISE_PLATFORM/bin

RUN apt-get install -y libxtst-dev libgtk2.0-dev

RUN export uid=1000 gid=1000 && \
    mkdir -p /home/eiffel && \
    echo "eiffel:x:${uid}:${gid}:eiffel,,,:/home/eiffel:/bin/bash" >> /etc/passwd && \
    echo "eiffel:x:${uid}:" >> /etc/group && \
    chown ${uid}:${gid} -R /home/eiffel

USER eiffel
ENV HOME /home/eiffel
