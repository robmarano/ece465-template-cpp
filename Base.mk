#
# Base.mk
#
# Our C++ projects will depend upon the Boost libraries
# to provide pre-packaged software libraries such as threading,
# networking, etc. Do NOT forget to configure BOOST_ROOT below.
#

export SERVER := threaded-server
export CLIENT := threaded-client

export BOOST_ROOT := /usr/local
export BOOST_INC := ${BOOST_ROOT}/include/boost
#export LDFLAGS := -L/usr/lib -L/usr/local/lib
#LDFLAGS  := -L./boost/stage/lib -L/usr/lib -lstdc++ -lm

export PROJECT_HOME := $(PWD)
export BUILD := $(PROJECT_HOME)/build
export CXX := -g++
#CXXFLAGS := -pedantic-errors -Wall -Wextra -Werror
#CXXFLAGS := -Wall -Wc++11-extensions -Wc++11-long-long
export CXXFLAGS := -g -w -Wfatal-errors
export LDFLAGS := $(LDFLAGS) -L/usr/lib -L/usr/local/lib -lstdc++ -std=c++11 -lm -lboost_thread-mt -lboost_program_options-mt -lboost_system -lboost_chrono
export OBJ_DIR := $(BUILD)/objects
export APP_DIR := $(BUILD)/apps
export INCLUDE := -I$(PROJECT_HOME)/include/ -I$(BOOST_INC)/
