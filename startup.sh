#!/bin/bash
## Set up FSL environment 

FSLDIR=/usr/share/fsl/5.0
. ${FSLDIR}/etc/fslconf/fsl.sh
PATH=${FSLDIR}/bin:${PATH}
export FSLDIR PATH 

echo "
Starting Jupyter Lab 

Exit with CTRL+D
"
case "$1" in 
  debug) 
    bash
  ;; 
      *)
    
    exec jupyter lab --ip=0.0.0.0 
  ;;
esac




