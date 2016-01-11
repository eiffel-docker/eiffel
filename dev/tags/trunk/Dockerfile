FROM eiffel/dev:dev
MAINTAINER Jocelyn Fiat

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

