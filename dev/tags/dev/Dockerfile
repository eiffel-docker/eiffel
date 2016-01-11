FROM eiffel/eiffel:dev
MAINTAINER Jocelyn Fiat

ENV PATH $PATH:$ISE_EIFFEL/studio/spec/$ISE_PLATFORM/bin:$ISE_EIFFEL/tools/spec/$ISE_PLATFORM/bin:$ISE_EIFFEL/library/gobo/spec/$ISE_PLATFORM/bin

USER root
RUN apt-get install -y sudo
RUN sudo adduser eiffel sudo
RUN echo "eiffel:eiffel" | chpasswd

RUN apt-get install -y xterm tmux
RUN apt-get install -y subversion git-all tig
RUN apt-get install -y vim

USER eiffel
ENV HOME /home/eiffel
ADD ../../inc/home/eiffel/.subversion /home/eiffel/.subversion

RUN iron update

WORKDIR /home/eiffel

##################################
# Custom EiffelStudio trunk dev. #
##################################
ENV EIFFEL_SRC /home/eiffel/trunk/Src
ENV ISE_LIBRARY $EIFFEL_SRC

RUN mkdir -p /home/eiffel/trunk
WORKDIR /home/eiffel/trunk
RUN svn checkout https://svn.eiffel.com/eiffelstudio/trunk/Src Src
WORKDIR $EIFFEL_SRC
RUN geant prepare

WORKDIR /home/eiffel
