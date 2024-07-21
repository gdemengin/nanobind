#!/bin/bash

set -e

# prepare build env
rm -rf .venv
python3.11 -m venv .venv
source .venv/bin/activate
python -m pip install --force-reinstall pip==24.1.2 scikit-build-core==0.9.6 nanobind==2.0.0 cmake==3.29.6
source /opt/rh/gcc-toolset-13/enable

set -x

# build
rm -rf build
python -m pip install --no-deps --verbose --force-reinstall --no-build-isolation .

# tests -> 80 bytes leak
rm -f *.log
LD_PRELOAD='/lib64/libasan.so.8' PYTHONMALLOC='malloc' LSAN_OPTIONS='suppressions=lsan.supp' python -c "import mre; mre.reproduce(b'666')" 2>&1 | tee nb2.0.0.log

# patch sources
cd .venv/lib/python3.11/site-packages/nanobind/src/
patch -p 0 < ../../../../../../ndarray-leak.patch
cd -

# rebuild
rm -rf build
python -m pip install --no-deps --verbose --force-reinstall --no-build-isolation .

# retests -> 80 bytes leak is gone
LD_PRELOAD='/lib64/libasan.so.8' PYTHONMALLOC='malloc' LSAN_OPTIONS='suppressions=lsan.supp' python -c "import mre; mre.reproduce(b'666')" 2>&1 | tee nb2.0.0+ndarray-leak.patch.log

diff nb2.0.0.log nb2.0.0+ndarray-leak.patch.log
