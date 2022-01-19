#!/bin/bash

tmp_docker_name=eiffel/eiffel

#docker build -f ../eiffel/tags/latest/Dockerfile -t local/eiffel .
#tmp_docker_name=local/eiffel

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
	--env USER_UID=$(id -u ${USER}) \
	--env USER_GID=$(id -g ${USER}) \
	-v `pwd`/test_src:/tmp/SRC \
	-v ${tmp_bin}:/tmp/BIN \
	--env APP_ECF=/tmp/SRC/testing.ecf \
	--env APP_TARGET=testing \
	--env APP_BIN=/tmp/BIN \
	--env APP_LOG=/tmp/BIN \
	--env IS_VERBOSE="true" \
	-u $(id -u ${USER}):$(id -g ${USER}) \
	$tmp_docker_name /tmp/BIN/.build.sh

	#--env ONLY_F_CODE="true" \

