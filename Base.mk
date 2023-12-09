#
# Base.mk
#
# Our C++ projects will depend upon the Boost libraries
# to provide pre-packaged software libraries such as threading,
# networking, etc. Do NOT forget to configure BOOST_ROOT below.
#

export ABS_REPO_PATH := $(shell git rev-parse --show-toplevel)

export SERVER := node-server
export CLIENT := svc-client

export BOOST_ROOT := /usr/local
export BOOST_LIB := $(BOOST_ROOT)/lib
export BOOST_INC := $(BOOST_ROOT)/include
#export BOOST_LIB_SUFFIX := -mt

export SERVED_ROOT := $(ABS_REPO_PATH)/served.build/build/libserved-1.4.3-Linux
export SERVED_LIB := $(SERVED_ROOT)/lib
export SERVED_INC := $(SERVED_ROOT)/include

#export LD_LIBRARY_PATH := ${BOOST_ROOT}/lib:${LD_LIBRARY_PATH}
export LDFLAGS := -L/usr/lib -L/usr/local/lib -L$(BOOST_LIB) -L$(SERVED_LIB)
export LDFLAGS := -pthread -std=c++11 $(LDFLAGS)

export PROJECT_HOME := $(PWD)
export BUILD := $(PROJECT_HOME)/build
export CXX := g++
export INCLUDE := -I$(BOOST_INC) -I$(SERVED_INC)
#CXXFLAGS := -pedantic-errors -Wall -Wextra -Werror
#CXXFLAGS := -Wall -Wc++11-extensions -Wc++11-long-long
export CXXFLAGS := -pedantic -pthread -g -w -Wfatal-errors
export OBJ_DIR := $(BUILD)/objects
export APP_DIR := $(BUILD)/apps
