#
# Base.mk
#
# Our C++ projects will depend upon the Boost libraries
# to provide pre-packaged software libraries such as threading,
# networking, etc. Do NOT forget to configure BOOST_ROOT below.
#

export SERVER := threaded-server
export CLIENT := threaded-client

#export BOOST_ROOT := $(HOME)/dev/boost_1_83_0
export BOOST_LIB := /usr/lib/x86_64-linux-gnu/
#export BOOST_LIB_SUFFIX := -mt
#export LD_LIBRARY_PATH := ${BOOST_ROOT}/lib:${LD_LIBRARY_PATH}
#export BOOST_INC := ${BOOST_ROOT}
export LDFLAGS := -L$(BOOST_LIB) -L/usr/lib -L/usr/local/lib
export LDFLAGS := -pthread -std=c++11 $(LDFLAGS)

export PROJECT_HOME := $(PWD)
export BUILD := $(PROJECT_HOME)/build
export CXX := g++
#export INCLUDE := -I$(BOOST_INC)
#CXXFLAGS := -pedantic-errors -Wall -Wextra -Werror
#CXXFLAGS := -Wall -Wc++11-extensions -Wc++11-long-long
export CXXFLAGS := -pedantic -pthread -g -w -Wfatal-errors
export OBJ_DIR := $(BUILD)/objects
export APP_DIR := $(BUILD)/apps
