FROM debian:latest
MAINTAINER Jocelyn Fiat

RUN apt-get update && apt-get install -y --no-install-recommends \
        ca-certificates curl \
        bzip2 \
        gcc make \
        libxtst-dev \
        libgtk2.0-dev \
        libgtk-3-dev \
        libgdk-pixbuf2.0-dev \
        libssl-dev \
        sudo vim \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV USER_UID=1000 USER_GID=1000

# Define Eiffel environment variables
ENV ISE_EIFFEL=/usr/local/eiffel \
    ISE_PLATFORM=linux-x86-64
ENV ISE_LIBRARY=$ISE_EIFFEL \
    PATH=$PATH:$ISE_EIFFEL/studio/spec/$ISE_PLATFORM/bin:$ISE_EIFFEL/tools/spec/$ISE_PLATFORM/bin:$ISE_EIFFEL/library/gobo/spec/$ISE_PLATFORM/bin:$ISE_EIFFEL/esbuilder/spec/$ISE_PLATFORM/bin

# Install using the latest PorterPackage
ADD ./src/install_porterpackage.sh /tmp/install_porterpackage.sh
RUN /bin/bash /tmp/install_porterpackage.sh $ISE_PLATFORM /home/eiffel/build $ISE_EIFFEL


# User "eiffel" 

RUN /usr/sbin/useradd \
	--uid ${USER_UID} \
	--create-home --home-dir /home/eiffel \
	--shell /bin/bash \
	--user-group --groups sudo \
	eiffel \
	&& $(echo "eiffel ALL=(ALL: ALL) NOPASSWD:ALL" >> /etc/sudoers)

#To set password, add the following line to the useradd command:
#	--password "$(openssl passwd -1 eiffel)"  \

# Set the environment in the .bashrc file to be persistent
RUN echo export ISE_EIFFEL=$ISE_EIFFEL >> /home/eiffel/.bashrc \
    && echo export ISE_PLATFORM=$ISE_PLATFORM >> /home/eiffel/.bashrc \
    && echo export ISE_LIBRARY=$ISE_LIBRARY >> /home/eiffel/.bashrc \
    && echo export PATH=\$PATH:\$ISE_EIFFEL/studio/spec/\$ISE_PLATFORM/bin:\$ISE_EIFFEL/tools/spec/\$ISE_PLATFORM/bin:\$ISE_EIFFEL/library/gobo/spec/\$ISE_PLATFORM/bin:\$ISE_EIFFEL/esbuilder/spec/\$ISE_PLATFORM/bin >> /home/eiffel/.bashrc

# Install .NETCore environment
ENV DOTNET_VERSION=6.0 \
	DOTNET_ROOT=/usr/lib/dotnet
RUN curl -fsSL --output /tmp/dotnet-install.sh https://dot.net/v1/dotnet-install.sh \
	&& chmod u+x /tmp/dotnet-install.sh \
	&& /tmp/dotnet-install.sh --version latest --channel ${DOTNET_VERSION} \
		--install-dir ${DOTNET_ROOT} \
	&& ln -s ${DOTNET_ROOT}/dotnet /usr/bin/dotnet \
	&& echo export DOTNET_ROOT=$DOTNET_ROOT >> /home/eiffel/.bashrc \
	&& echo export PATH=\$PATH:\$DOTNET_ROOT:\$DOTNET_ROOT/tools >> /home/eiffel/.bashrc

USER eiffel
ENV HOME=/home/eiffel
WORKDIR /home/eiffel
