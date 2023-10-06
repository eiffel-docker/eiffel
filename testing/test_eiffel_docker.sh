#!/bin/bash

tmp_docker_name=eiffel/eiffel
docker_container_command=/tmp/BIN/.build.sh
docker_container_opts=
tmp_user_line="--env USER_UID=$(id -u ${USER}) --env USER_GID=$(id -g ${USER}) -u $(id -u ${USER}):$(id -g ${USER})"

while [ -n "$1" ]
do
	case "$1" in
		local)
			docker build -f ../eiffel/tags/latest/Dockerfile -t local/eiffel .
			tmp_docker_name=local/eiffel
			;;
		shell)
			docker_container_command=/bin/bash
			;;
		gui)
			docker_container_opts="-v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY -h $HOSTNAME -v $HOME/.Xauthority:/home/eiffel/.Xauthority"
			;;
		studio)
			docker_container_opts="-v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY -h $HOSTNAME -v $HOME/.Xauthority:/home/eiffel/.Xauthority"
			docker_container_command=estudio
			;;
		root)
			tmp_user_line="-u root"
			;;
		*)
			docker_container_command=$1
			;;
	esac
	shift
done


tmp_cwd=`pwd`
tmp_bin=${tmp_cwd}/BIN
tmp_var=${tmp_cwd}/docker-var

rm -rf ${tmp_bin}
mkdir -p ${tmp_bin}

cat > ${tmp_bin}/.build.sh << EndOfScript
#!/bin/sh
echo Build \$APP_ECF target \$APP_TARGET into \$APP_BIN

tmp_opts=""
if [ "\$ONLY_F_CODE" = "true" ]; then 
	if [ -z "\$APP_TARGET" ]; then 
		echo ERROR: variable APP_TARGET is required
	fi 

	if [ ! -z "\$APP_LOG" ]; then 
		ec ${tmp_opts} -finalize -config \$APP_ECF -target \$APP_TARGET -project_path /tmp  | tee \${APP_LOG}/build.log
	else
		ec ${tmp_opts} -finalize -config \$APP_ECF -target \$APP_TARGET -project_path /tmp  | tee \${APP_LOG}/build.log
	fi

	cd /tmp/EIFGENs/
	tar czf \${APP_BIN}/\${APP_TARGET}.tgz */F_code
else
	if [ "\$IS_VERBOSE" = "true" ]; then 
		tmp_opts="\$tmp_opts -v"
	fi 
	if [ ! -z "\$APP_TARGET" ]; then 
		tmp_opts="\$tmp_opts --target \$APP_TARGET"
	fi 
	echo eiffel build \${tmp_opts} \$APP_ECF -o \$APP_BIN/\${APP_TARGET}

	if [ ! -z "\$APP_LOG" ]; then 
		eiffel build \${tmp_opts} \$APP_ECF -o \$APP_BIN/\${APP_TARGET} | tee \${APP_LOG}/build.log
	else
		eiffel build \${tmp_opts} \$APP_ECF -o \$APP_BIN/\${APP_TARGET}
	fi
fi
EndOfScript
chmod a+x ${tmp_bin}/.build.sh

docker run --rm -it \
	-v `pwd`/test_src:/tmp/SRC \
	-v ${tmp_bin}:/tmp/BIN \
	--env APP_ECF=/tmp/SRC/testing.ecf \
	--env APP_TARGET=testing \
	--env APP_BIN=/tmp/BIN \
	--env APP_LOG=/tmp/BIN \
	--env IS_VERBOSE="true" \
	-v /tmp:/tmp \
	$tmp_user_line \
	$docker_container_opts \
	$tmp_docker_name $docker_container_command

	#--env ONLY_F_CODE="true" \

