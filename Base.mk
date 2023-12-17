#
# Base.mk
#
# Our C++ projects will depend upon the Boost libraries
# to provide pre-packaged software libraries such as threading,
# networking, etc. Do NOT forget to configure BOOST_ROOT below.
#

export ABS_REPO_PATH := $(shell git rev-parse --show-toplevel)

export TARGET := zkApp

export BOOST_ROOT := /usr/local
export BOOST_LIB := $(BOOST_ROOT)/lib
export BOOST_INC := $(BOOST_ROOT)/include

# zookeeper-cpp code
export ZKCPP=$(ABS_REPO_PATH)/zookeeper-cpp/src
export ZKCPPBUILD=$(ABS_REPO_PATH)/zookeeper-cpp.build

# served code
export SERVED_ROOT := $(ABS_REPO_PATH)/served.build/build/libserved-1.4.3-Linux
export SERVED_LIB := $(SERVED_ROOT)/lib
export SERVED_INC := $(SERVED_ROOT)/include


export CXX := g++
export INCLUDE := -I. -I$(ZKCPP) -I$(BOOST_ROOT)/include -DZKPP_FUTURE_USE_BOOST
export CFLAGS := -DDEBUG -DTHREADED -pedantic -pthread -g -w -std=c++17 -fpermissive #-Wfatal-errors 
export LDFLAGS := -L$(BOOST_LIB) -L$(ZKCPPBUILD) -L$(SERVED_LIB) -L/usr/lib -L/usr/local/lib
export LDFLAGS := -pthread -std=c++11 $(LDFLAGS) -lboost_thread -lzkpp -lzkpp-server #-lserved


export PROJECT_HOME := $(ABS_REPO_PATH)
export BUILD := $(PROJECT_HOME)/build

export OBJ_DIR := $(BUILD)/objects
export APP_DIR := $(BUILD)/apps
