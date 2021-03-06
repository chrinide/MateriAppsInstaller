port selfupdate         
port -N install ld64 +ld64_xcode
port -N install gcc7 openmpi-gcc7
port select --set gcc mp-gcc7
port select --set mpi openmpi-gcc7-fortran
port -N install wget subversion scalapack +gcc7 +openmpi fftw-3 +gfortran fftw-3-single +gfortran gsl +gcc7
port -N install qt4-mac
port -N install hdf5 +gcc7 +threadsafe
port -N install gnuplot

port -N install python27 py27-pip py27-scipy py27-matplotlib
port select --set python python27
port select --set python2 python27
rm -f /opt/local/bin/pip /opt/local/bin/pip2
ln -s pip-2.7 /opt/local/bin/pip2
ln -s pip2 /opt/local/bin/pip
port -N install py27-virtualenv
port select --set virtualenv virtualenv27
port -N install py27-jupyter
port select --set ipython py27-ipython
port select --set ipython2 py27-ipython
port -N install py27-wxpython-2.8 py27-opengl py27-mako py27-mpi4py +gcc7 +openmpi py27-h5py +gcc7 -openmpi

port -N install python36 py36-pip py36-scipy py36-matplotlib
port select --set python3 python36
rm -f /opt/local/bin/pip3
ln -s pip-3.6 /opt/local/bin/pip3
port -N install py36-jupyter
port select --set ipython3 py36-ipython
rm -f /opt/local/bin/jupyter
ln -s jupyter-3.6 /opt/local/bin/jupyter
