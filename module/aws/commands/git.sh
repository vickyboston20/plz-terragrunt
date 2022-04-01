#!/bin/bash
set -e -o pipefail
if [ ${MODULE_NAME} == 'git-to-s3' ]
then
    rm -rf ../${MODULE_NAME}/python_files
    git clone https://github.com/vickyboston20/plz-lambda.git ../${MODULE_NAME}/python_files
else
    echo "${MODULE_NAME} not having repo"
fi

echo "Done"