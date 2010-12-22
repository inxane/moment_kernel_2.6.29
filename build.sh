#!/bin/bash

PRODUCT=SPH-M900
REV=00
OPTION=-k

case "$PRODUCT" in
	
	SPH-M900)
		REALPRODUCT=$PRODUCT
		MODULES="camera cmm g2d g3d jpeg mfc pp rotator btgpio vibetonz camera dpram wlan"
		KERNEL_DEF_CONFIG=m900_android_defconfig 
		;;
esac 

if [ ! $PWD_DIR ] ; then
	PWD_DIR=$(pwd)
fi

WORK_DIR=$PWD_DIR/src
OUT_DIR=$PWD_DIR/OUTDIR
INITRAM_DIR=$WORK_DIR/dj07
KERNEL_DIR=$WORK_DIR/kernel
MODULES_DIR=$WORK_DIR/modules


build_kernel()
{
	echo *************************************
	echo *           build kernel            *
	echo *************************************
		rm $OUT_DIR/zImage
		cd $KERNEL_DIR

		rm -f usr/initramfs_data.cpio.gz

		echo make clean
		make clean

		echo make

		make
		if [ $? != 0 ] ; then
			exit $?
		fi

}

build_kernel_clean()
{
	echo *************************************
	echo *           build kernel            *
	echo *************************************
		
		cd $KERNEL_DIR

		rm -f usr/initramfs_data.cpio.gz

		echo make clean
		make clean

		echo make

		make
		if [ $? != 0 ] ; then
			exit $?
		fi

		case "$PRODUCT" in
			
	    	SPH-M900)
	      if [ $REALPRODUCT = SPH-M900 ] ; then
			     cd $KERNEL_DIR/arch/arm/boot
			     cp zImage $OUT_DIR/zImage
			cd $KERNEL_DIR
			make clean
			cp $OUT_DIR/zImage /home/kareem/Downloads/boot\ kernel/system/zImage
			cd /home/kareem/Downloads/boot\ kernel
			rm inxanexxx.zip
			7z a inxanexxx.zip *
				fi
				;;
		esac
}

build_modules()
{
	echo *************************************
	echo *           build modules           *
	echo *************************************

	for module in $MODULES
	do
		echo cd $MODULES_DIR/$module
		cd $MODULES_DIR/$module
		make clean
		make KDIR=$KERNEL_DIR PRJROOT=$WORK_DIR && \
		    cp *.ko $INITRAM_DIR/lib/modules
		make clean
		if [ "$?" -ne 0 ]; then
		    echo "*ERROR* while building $modules"
		    exit -1
		fi
	done

}


if [ ! -d $OUT_DIR ] ; then
	mkdir -p $OUT_DIR
fi

case "$OPTION" in
	
	-k)
			build_kernel
			build_modules
			build_kernel_clean
		;;
	*)
		Usage
		;;
esac 

echo ""
echo "Total spent time:"
times
	
exit 0
