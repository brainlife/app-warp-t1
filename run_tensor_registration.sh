#!/bin/bash

tensor_dir=$1
warp_dir=$2

#------------------------------------------------------------------------------
# tensor warping
#------------------------------------------------------------------------------

mkdir -p tensor_aligned
OUT=tensor_aligned

for file_path in ${tensor_dir}/*; do

    filename=$(basename $file_path)

    WarpImageMultiTransform 3  \
    	$file_path \
	${OUT}/${filename} \
	warp_dir/warp.nii.gz \
	warp_dir/affine.txt  --use-NN

    echo -e "${OUT}/${filename} saved.\n"	

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
