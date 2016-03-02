FROM debian:latest
MAINTAINER Jocelyn Fiat

RUN apt-get update && apt-get -y install curl bzip2 make gcc libxtst-dev libgtk2.0-dev

RUN export uid=1000 gid=1000 && \
    mkdir -p /home/eiffel && \
    echo "eiffel:x:${uid}:${gid}:eiffel,,,:/home/eiffel:/bin/bash" >> /etc/passwd && \
    echo "eiffel:x:${uid}:" >> /etc/group && \
    chown ${uid}:${gid} -R /home/eiffel

# Define Eiffel environment variables
ENV ISE_PLATFORM linux-x86-64
ENV ISE_EIFFEL /usr/local/Eiffel
ENV ISE_LIBRARY $ISE_EIFFEL
ENV HOME /home/eiffel

USER eiffel
RUN mkdir -p /home/eiffel/build && curl -L https://ftp.eiffel.com/pub/beta/nightly/PorterPackage_NIGHTLY.tar | tar x -C /home/eiffel/build
RUN cd /home/eiffel/build/PorterPackage && ls -la /home/eiffel/build/* && /home/eiffel/build/PorterPackage/compile_exes $ISE_PLATFORM
ENV PATH $PATH:$ISE_EIFFEL/studio/spec/$ISE_PLATFORM/bin:$ISE_EIFFEL/tools/spec/$ISE_PLATFORM/bin:$ISE_EIFFEL/library/gobo/spec/$ISE_PLATFORM/bin

USER root
RUN mv /home/eiffel/build/PorterPackage/Eiffel_*.* $ISE_EIFFEL

USER eiffel
