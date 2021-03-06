#!/bin/sh

SCRIPT_DIR=$(cd "$(dirname $0)"; pwd)
. $SCRIPT_DIR/../util.sh
set_prefix
. $PREFIX_TOOL/env.sh
. $SCRIPT_DIR/version.sh

GSLVARS_SH=$PREFIX_TOOL/gsl/gslvars-$GSL_VERSION-$GSL_MA_REVISION.sh
rm -f $PREFIX_TOOL/env.d/gslvars.sh
ln -s $GSLVARS_SH $PREFIX_TOOL/env.d/gslvars.sh
