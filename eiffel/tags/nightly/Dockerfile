FROM debian:latest
MAINTAINER Jocelyn Fiat

RUN apt-get update && apt-get install -y --no-install-recommends \
        ca-certificates curl \
        bzip2 \
        gcc make \
        libxtst-dev \
        libgtk2.0-dev \
        libssl-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*


# Define Eiffel environment variables
ENV	ISE_EIFFEL=/usr/local/eiffel \
	ISE_PLATFORM=linux-x86-64
ENV	ISE_LIBRARY=$ISE_EIFFEL \
    PATH=$PATH:$ISE_EIFFEL/studio/spec/$ISE_PLATFORM/bin:$ISE_EIFFEL/tools/spec/$ISE_PLATFORM/bin:$ISE_EIFFEL/library/gobo/spec/$ISE_PLATFORM/bin:$ISE_EIFFEL/esbuilder/spec/$ISE_PLATFORM/bin

ADD ./src/install_porterpackage.sh /tmp/install_porterpackage.sh
RUN /bin/bash /tmp/install_porterpackage.sh $ISE_PLATFORM /home/eiffel/build $ISE_EIFFEL

RUN export uid=1000 gid=1000 && \
    mkdir -p /home/eiffel && \
    echo "eiffel:x:${uid}:${gid}:eiffel,,,:/home/eiffel:/bin/bash" >> /etc/passwd && \
    echo "eiffel:x:${uid}:" >> /etc/group && \
    chown ${uid}:${gid} -R /home/eiffel

USER eiffel
ENV HOME /home/eiffel
