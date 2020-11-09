#!/bin/bash

tensor_dir=$1
warp_dir=$2

#------------------------------------------------------------------------------
# tensor warping
#------------------------------------------------------------------------------

mkdir -p tensor_aligned
OUT=tensor_aligned

for filename in ${tensor_dir}; do

WarpImageMultiTransform 3  \
	$filename \
	${OUT}/${filename} \
	warp_dir/warp.nii.gz \
	warp_dir/affine.txt  --use-NN

echo "${OUT}/${filename} saved."	

done

#------------------------------------------------------------------------------
# Checks
#------------------------------------------------------------------------------

if  [ -z "$(ls -A -- "tensor_aligned")" ]; then    
	echo "Tensor warping failed."
	exit 1
else    
	echo "Tensor warping done."
fi
