#!/bin/bash

working_path=/tmp/scripts_to_run

# Create working path if needed
if [ ! -e $working_path ]; then
    mkdir $working_path
fi

VERSION=$(cat version.txt)
echo "version: $VERSION"

docker build -t bash-scripts-executor:$VERSION .
docker run -it -e WORKING_PATH=$working_path -v $working_path:$working_path bash-scripts-executor:$VERSION