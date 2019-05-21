#!/bin/sh

t_eif_platform=$1
t_eif_build_dir=$2
t_eif_install_dir=$3
t_clean="yes"
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
	echo "curl -s -L $l_url | tar x -C $l_build_dir"
	curl -s -L $l_url | tar x -C $l_build_dir
}

mkdir -p $t_eif_build_dir
cd $t_eif_build_dir

get_porterpackage $t_porterpackage_url $t_eif_build_dir

cd PorterPackage

echo Compile the PorterPackage executables
taskset -c 0 ./compile_exes $t_eif_platform


echo Move Eiffel_... to $t_eif_install_dir
mv $t_eif_build_dir/PorterPackage/Eiffel_*.* $t_eif_install_dir



if [ -d $t_eif_install_dir ]; then
	echo Clean PorterPackage compilation...
	cp $t_eif_build_dir/PorterPackage/compile.log $t_eif_install_dir/PorterPackage.log
	if [ "$t_clean" = "yes" ]; then
		echo Deleting PorterPackage directory.
		rm -rf $t_eif_build_dir
	fi

	echo Completed.
else

	echo PorterPackage build failed!
fi

