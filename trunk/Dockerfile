FROM eiffel/eiffel:latest
MAINTAINER Jocelyn Fiat

ENV EIFFEL_SRC /home/eiffel/trunk/Src
ENV ISE_LIBRARY $EIFFEL_SRC
ENV PATH $PATH:$ISE_EIFFEL/studio/spec/$ISE_PLATFORM/bin:$ISE_EIFFEL/tools/spec/$ISE_PLATFORM/bin:$ISE_EIFFEL/library/gobo/spec/$ISE_PLATFORM/bin

USER root
RUN apt-get install -y sudo
RUN sudo adduser eiffel sudo
RUN echo "eiffel:eiffel" | chpasswd

RUN apt-get install -y xterm
RUN apt-get install -y subversion git-all

USER eiffel
ENV HOME /home/eiffel
ADD ./home/eiffel/.subversion /home/eiffel/.subversion
RUN mkdir -p /home/eiffel/trunk
WORKDIR /home/eiffel/trunk
RUN svn checkout https://svn.eiffel.com/eiffelstudio/trunk/Src Src
WORKDIR /home/eiffel/trunk/Src
RUN geant prepare
WORKDIR /home/eiffel

