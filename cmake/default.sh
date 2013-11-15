#!/bin/sh

SCRIPT_DIR=`dirname $0`
. $SCRIPT_DIR/../util.sh
. $SCRIPT_DIR/version.sh
set_prefix
set_build_dir

cd $BUILD_DIR
rm -rf cmake-$CMAKE_VERSION
if [ -f $HOME/source/cmake-$CMAKE_VERSION.tar.gz ]; then
  check tar zxf $HOME/source/cmake-$CMAKE_VERSION.tar.gz
else
  check wget -O - http://www.cmake.org/files/v2.8/cmake-2.8.12.1.tar.gz | tar zxf -
fi
cd cmake-$CMAKE_VERSION
check ./bootstrap --prefix=$PREFIX_OPT
check make -j4
check sudo make install
