#!/bin/sh
# script alps_source prefix

if [ -n "$2" ]; then
  PREFIX_ALPS="$2"
fi

SCRIPT_DIR=$(cd "$(dirname $0)"; pwd)
. $SCRIPT_DIR/../util.sh
. $SCRIPT_DIR/version.sh
. $SCRIPT_DIR/../03_boost/version.sh
set_prefix
set_build_dir

. $PREFIX_OPT/env.sh

if [ -n "$1" ]; then
  ALPS_VERSION="svn"
  ALPS_SOURCE="$1"
else
  ALPS_SOURCE="$BUILD_DIR/alps-$ALPS_VERSION"
  cd $BUILD_DIR
  if [ -d alps-$ALPS_VERSION ]; then :; else
    if [ -f $HOME/source/alps-$ALPS_VERSION.tar.gz ]; then
      check tar zxf $HOME/source/alps-$ALPS_VERSION.tar.gz
    else
      check wget -O - http://exa.phys.s.u-tokyo.ac.jp/archive/source/alps-$ALPS_VERSION.tar.gz | tar zxf -
    fi
  fi
  rm -rf $BUILD_DIR/alps-build-$ALPS_VERSION
fi

mkdir -p $BUILD_DIR/alps-build-$ALPS_VERSION
cd $BUILD_DIR/alps-build-$ALPS_VERSION
rm -rf CMakeCache.txt CPackConfig.cmake CPackSourceConfig.cmake CMakeFiles/2.*
echo "[cmake]"
check cmake -DCMAKE_INSTALL_PREFIX=$PREFIX_ALPS/alps-$ALPS_VERSION \
  -DPYTHON_INTERPRETER=python2.7 \
  -DHdf5_INCLUDE_DIRS=$PREFIX_OPT/include -DHdf5_LIBRARY_DIRS=$PREFIX_OPT/lib \
  -DBoost_ROOT_DIR=$PREFIX_OPT/boost_$BOOST_VERSION \
  -DALPS_ENABLE_OPENMP=ON -DALPS_ENABLE_OPENMP_WORKER=ON \
  -DALPS_BUILD_FORTRAN=ON -DALPS_BUILD_TESTS=ON -DALPS_BUILD_PYTHON=ON \
  -DBLAS_LIBRARY=-lblas -DLAPACK_LIBRARY=-llapack \
  $ALPS_SOURCE

echo "[make install]"
check make -j2 install
echo "[ctest]"
ctest

cat << EOF > $PREFIX_ALPS/alpsvars-$ALPS_VERSION.sh
. $PREFIX_OPT/env.sh
. $PREFIX_ALPS/alps-$ALPS_VERSION/bin/alpsvars.sh
EOF
rm -f $PREFIX_ALPS/alpsvars.sh
ln -s alpsvars-$ALPS_VERSION.sh $PREFIX_ALPS/alpsvars.sh