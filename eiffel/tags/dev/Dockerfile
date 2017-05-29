FROM debian:latest
MAINTAINER Jocelyn Fiat

RUN apt-get update \
	&& apt-get -y install curl bzip2 make gcc \
	&& apt-get -y install libxtst-dev libgtk2.0-dev \
	&& rm -rf /var/lib/apt/lists/*

#RUN curl -L https://ftp.eiffel.com/pub/beta/nightly/Eiffel_17.05_gpl_100416-linux-x86-64.tar.bz2 | tar xj -C /usr/local
RUN curl -L https://ftp.eiffel.com/pub/download/17.05/Eiffel_17.05_gpl_100416-linux-x86-64.tar.bz2 | tar xj -C /usr/local

# Define Eiffel environment variables
ENV 	ISE_EIFFEL=/usr/local/Eiffel_17.05 \
	ISE_PLATFORM=linux-x86-64 \
	ISE_LIBRARY=$ISE_EIFFEL \
	PATH=$PATH:$ISE_EIFFEL/studio/spec/$ISE_PLATFORM/bin:$ISE_EIFFEL/tools/spec/$ISE_PLATFORM/bin:$ISE_EIFFEL/library/gobo/spec/$ISE_PLATFORM/bin


RUN export uid=1000 gid=1000 && \
    mkdir -p /home/eiffel && \
    echo "eiffel:x:${uid}:${gid}:eiffel,,,:/home/eiffel:/bin/bash" >> /etc/passwd && \
    echo "eiffel:x:${uid}:" >> /etc/group && \
    chown ${uid}:${gid} -R /home/eiffel

USER eiffel
ENV HOME /home/eiffel
