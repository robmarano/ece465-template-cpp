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

clean:
	-@rm -rvf $(OBJ_DIR)/*
	-@rm -rvf $(APP_DIR)/*
	-@rm -rvf $(BUILD)
	-@rm *.log
