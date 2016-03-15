#!/bin/sh

t_eif_platform=$1
t_eif_build_dir=$2
t_eif_install_dir=$3
case "$4" in
    "--keep") t_clean="no";;
    "--clean") t_clean="yes";;
    *) t_clean="yes";;
esac

# Script
t_porterpackage_url=https://ftp.eiffel.com/pub/beta/nightly/PorterPackage_NIGHTLY.tar

#Function declarations

get_porterpackage () {
	l_url=$1
	l_build_dir=$2

	echo Get PorterPackage archive from $l_url .
	curl -s -L $l_url | tar x -C $l_build_dir
}

fix_runtime () {
	t_old_cwd=`pwd`
	t_pp_dir=$1

	cd $t_pp_dir
	echo "Fix Eiffel runtime, by replacing sys_siglist[sig] by strsignal(sig)"
	
	\rm -rf C
	tar xjvf c.tar.bz2
	sed "s/sys_siglist\[\(..*\)]/strsignal(\1)/g" C/run-time/sig.c > C/run-time/sig.c.new && mv C/run-time/sig.c.new C/run-time/sig.c
	tar cjvf c.tar.bz2 C/*
	\rm -rf C

	echo Eiffel runtime fixed.
	cd $t_old_cwd
}

mkdir -p $t_eif_build_dir
cd $t_eif_build_dir

get_porterpackage $t_porterpackage_url $t_eif_build_dir
fix_runtime $t_eif_build_dir/PorterPackage

cd PorterPackage

echo Compile the PorterPackage executables
taskset -c 0 ./compile_exes $t_eif_platform


echo Move Eiffel_... to $t_eif_install_dir
mv $t_eif_build_dir/PorterPackage/Eiffel_*.* $t_eif_install_dir



if [ -d $t_eif_install_dir ]; then
	echo Clean PorterPackage compilation...
	cp $t_eif_build_dir/PorterPackage/compile.log $t_eif_install_dir/PorterPackage.log
	if [ "$t_clean" == "yes" ]; then
		echo Deleting PorterPackage directory.
		rm -rf $t_eif_build_dir
	fi

	echo Completed.
else

	echo PorterPackage build failed!
fi

