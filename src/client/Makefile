#
# krevma/src/client
#
include ../../Base.mk

TARGET := $(CLIENT)
INCLUDE := -I. $(INCLUDE)

SRC      := $(wildcard ./*.cpp)

OBJECTS := $(SRC:%.cpp=$(OBJ_DIR)/%.o)

all: build $(APP_DIR)/$(TARGET)

$(OBJ_DIR)/%.o: %.cpp
	@mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) $(INCLUDE) -o $@ -c $<

$(APP_DIR)/$(TARGET): $(OBJECTS)
	@mkdir -p $(@D)
	$(CXX) $(LDFLAGS) -o $(APP_DIR)/$(TARGET) $(OBJECTS)

.PHONY: all build clean debug release

build:
	@mkdir -p $(APP_DIR)
	@mkdir -p $(OBJ_DIR)

debug: CXXFLAGS += -DDEBUG -g
debug: all

release: CXXFLAGS += -O2
release: all

client: $(APP_DIR)/$(CLIENT)
	$(APP_DIR)/$(CLIENT)
client: all

run: $(APP_DIR)/$(TARGET)
	LD_LIBRARY_PATH=/usr/lib:/usr/local/lib:$(LD_LIBRARY_PATH) \
		$(APP_DIR)/$(CLIENT) $(APP_DIR)/$(TARGET)

