# HOWTO &mdash; Using Boost on Ubuntu

Choose either
1. Install Boost with package manager, or
2. Building Boost

Then build and run the included client and server from the top level of this code repository:
1. ```make clean```
2. ```make```
3. ```./run-server.sh```
4. ```./run-client.sh```

## Install Boost using system package manager ```apt```

### Install with package manager
```bash
 sudo apt install -y libboost-all-dev
```

### Uninstall and purge Boost from your system
```bash
 sudo apt autoremove libboost-all-dev
```

## Install Boost by building and installing
We will get Boost source code, configure it to build with multithreading support, install in ```/usr/local```, the go back to running the client and server instructions at the top of this document.

### Update Ubuntu OS
```bash
sudo apt update
sudo apt upgrade -y
```

### Install dependencies
Run the following to ensure you have the necessary tools on your Ubuntu system to compile Boost.

```bash
sudo apt install  build-essential curl libicu-dev icu-devtools libbz2-dev libffi-dev liblzma-dev libncursesw5-dev libreadline-dev libsqlite3-dev libssl-dev libxml2-dev libxmlsec1-dev llvm make cmake automake autoconf tk-dev wget xz-utils zlib1g-dev python3
```

### Fetch the Boost distribution
```bash
cd $HOME
mkdir -p $HOME/dev
cd $HOME/dev
wget https://boostorg.jfrog.io/artifactory/main/release/1.83.0/source/boost_1_83_0.tar.gz
```

### Uncompress the Boost distribution
```bash
cd $HOME/dev
tar xvfz ./boost_1_83_0.tar.gz
```

### Configure Boost
Define the shell variable ```BOOST_ROOT``` as ```$HOME/dev/boost_1_83_0```.
```bash
export BOOST_ROOT = $HOME/dev/boost_1_83_0
```

Then configure the Boost build system.
```bash
cd ${BOOST_ROOT}
./bootstrap.sh toolset=gcc --prefix=/usr/local --with-toolset=gcc --with-python=python3 --with-icu
```

### Build Boost Libraries
```bash
cd $HOME/dev/boost_1_83_0
NUM_CORES=$(cat /proc/cpuinfo | grep processor | wc -l)
./b2 stage -j${NUM_CORES} -q -a -d0 --reconfigure toolset=gcc threading=multi --layout=system variant=release --without-graph_parallel --build-type=minimal cxxflags="-std=c++11 -w" linkflags="-lm -lpthread"
```
With this build, you create the libraries and header files in ```${BOOST_ROOT}/stage``` directory. All the Boost libraries will be in ```${BOOST_ROOT}/stage/lib```. All the include files will be in ```${BOOST_ROOT}/boost```. At this point you have not installed into the system directory that you define in the ```--prefix``` parameter in the step above when you ran ```bootstrap.sh```

### Adjust the Make variables for Boost in ```Base.mk```
In the ```Base.mk``` file you need to change the following to use the staging.
```Makefile
export BOOST_ROOT := $(HOME)/dev/boost_1_83_0
export BOOST_LIB := $(BOOST_ROOT)
export BOOST_INC := $(BOOST_ROOT)
```

### Build Boost
```Makefile
make clean && make
```

### Test with the client and server programs
```Makefile
./run-server.sh
./run-client.sh
```

### Install the Boost libraries and include files
If you would like to install the Boost libraries into the prefixed directory, then run the following command in ${BOOST_ROOT} and also update the ${BOOST_ROOT} variables in Base.mk, run-server.sh, and run-client.sh.
```bash
cd $HOME/dev/boost_1_83_0
NUM_CORES=$(cat /proc/cpuinfo | grep processor | wc -l)
sudo ./b2 install -j${NUM_CORES} -q -a -d0 --reconfigure toolset=gcc threading=multi --layout=system variant=release --without-graph_parallel --build-type=minimal cxxflags="-std=c++11 -w" linkflags="-lm -lpthread"
```

Voila, you're done!

Contact me if you have any issues, simply post an issue in this repo.
Thank you!
./rob