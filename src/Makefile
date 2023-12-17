#
# src/Makefile
#

include ../Base.mk

SRC      :=  $(wildcard *.cpp)

OBJECTS := $(SRC:%.cpp=$(OBJ_DIR)/%.o)

all: build $(APP_DIR)/$(TARGET)

$(OBJ_DIR)/%.o: %.cpp
	$(CXX) -c $(CFLAGS) $(INCLUDE) -o $@ $<

$(APP_DIR)/$(TARGET): $(OBJECTS)
	$(CXX) -o $(APP_DIR)/$(TARGET) $(OBJECTS) $(LDFLAGS)

.PHONY: all build clean debug release

build:
	@mkdir -p $(APP_DIR)
	@mkdir -p $(OBJ_DIR)