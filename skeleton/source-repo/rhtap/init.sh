#!/bin/bash
SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )" 


# clean all results for each run.
# do it once, each task loading common will reinitialize the results for that task
DIR=$(pwd) 
rm -rf $DIR/results
mkdir -p $DIR/results

source $SCRIPTDIR/common.sh

# tools 
REQUIRED_BINARY="git curl jq yq "
# build binaries
REQUIRED_BINARY+="buildah syft cosign "
# runtimes 
REQUIRED_BINARY+="python3 " 
REQUIRED_BINARY+="buildah-login " 
# scans
#REQUIRED_BINARY+="roxctl "
REQUIRED_ENV="IMAGE_URL IMAGE " 

rhtap/verify-deps-exist "$REQUIRED_ENV" "$REQUIRED_BINARY" 
ERR=$?
echo "Dependency Error $1 = $ERR" 
if [ $ERR != 0 ]; then
	echo "Fatal Error code for $1 = $ERR" 
	exit_with_fail_result
fi

# For now, always build. 
function init() {
	echo "Running $TASK_NAME:init"
	#!/bin/bash
	echo "Build Initialize: $IMAGE_URL" 	
	echo "Determine if Image Already Exists"
	# Build the image when rebuild is set to true or image does not exist
	# The image check comes last to avoid unnecessary, slow API calls
	if [ "$REBUILD" == "true" ] || [ "$SKIP_CHECKS" == "true" ] || ! oc image info $IMAGE_URL &>/dev/null; then
	  echo -n "true" > $RESULTS/build
	else
	  echo -n "false" > $RESULTS/build
	fi
	
}

# Task Steps 
init
exit_with_success_result