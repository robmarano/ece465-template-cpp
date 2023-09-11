#
# threaded
#
include ./Base.mk

#TOPTARGETS := all clean

#SUBDIRS := $(wildcard */.)
SUBDIRS := src

.PHONY: $(TOPTARGETS) $(SUBDIRS) clean

$(TOPTARGETS): $(SUBDIRS)
	
$(SUBDIRS):
	+$(MAKE) -C $@ $(MAKECMDGOALS)

$(BUILD):
	echo $(BUILD)
	mkdir -p $(BUILD)

server: $(BUILD)
	LD_LIBRARY_PATH=${BOOST_ROOT}/lib:/usr/lib $(APP_DIR)/$(SERVER) $(APP_DIR)/$(SERVER)

client: $(BUILD)
	LD_LIBRARY_PATH=${BOOST_ROOT}/lib:/usr/lib $(APP_DIR)/$(CLIENT) $(APP_DIR)/$(CLIENT)

clean:
	-@rm -rvf $(OBJ_DIR)/*
	-@rm -rvf $(APP_DIR)/*
	-@rm -rvf $(BUILD)
