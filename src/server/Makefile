#
# krevma/src/server
#
include ../../Base.mk

TARGET := $(SERVER)
INCLUDE := -I. $(INCLUDE)
NEED_BOOST_LIBS := -l boost_system$(BOOST_LIB_SUFFIX) -l boost_chrono$(BOOST_LIB_SUFFIX) -l boost_program_options$(BOOST_LIB_SUFFIX) -l boost_thread$(BOOST_LIB_SUFFIX)
#NEED_BOOST_LIBS := -l boost_chrono$(BOOST_LIB_SUFFIX)

SRC      :=  $(wildcard *.cpp)

OBJECTS := $(SRC:%.cpp=$(OBJ_DIR)/%.o)

all: build $(APP_DIR)/$(TARGET)

$(OBJ_DIR)/%.o: %.cpp
	@mkdir -p $(@D)
	$(CXX) -c $(CXXFLAGS) $(INCLUDE) -o $@ $<

$(APP_DIR)/$(TARGET): $(OBJECTS)
	@mkdir -p $(@D)
	$(CXX) $(LDFLAGS) -o $(APP_DIR)/$(TARGET) $(OBJECTS) $(NEED_BOOST_LIBS)

.PHONY: all build clean debug release

build:
	@mkdir -p $(APP_DIR)
	@mkdir -p $(OBJ_DIR)