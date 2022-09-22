#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
CURRENT_DIR=$(pwd)

cd $SCRIPT_DIR
cd ..

python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt

ansible-galaxy install -r requirements.yml

cd $CURRENT_DIR
