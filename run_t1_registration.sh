#!/bin/bash

t1=$1
warp_dir=$2

mkdir -p t1_aligned

if [ -f t1_aligned/t1.nii.gz ]; then
	echo "T1 already registered."
else
	WarpImageMultiTransform 3  \
	    	$t1 \
	    	t1_aligned/t1.nii.gz \
	    	warp_dir/warp.nii.gz \
	    	warp_dir/affine.txt  --use-NN

	if [ -z "$(ls -A -- t1_aligned)" ]; then    
		echo "T1 warping failed."
		exit 1
	else    
		echo -e "T1 warping done.\n"
	fi    	
fi
