#!/bin/bash

set -e

# prepare build env
rm -rf .venv
python${1:-3.12} -m venv .venv
source .venv/bin/activate
python -m pip install --force-reinstall pip==24.2 scikit-build-core==0.9.6 nanobind==2.1.0 cmake==3.29.6
source /opt/rh/gcc-toolset-13/enable

set -x

# build
rm -rf build
python -m pip install --no-deps --verbose --force-reinstall --no-build-isolation .

python test-none-field.py
