#
# src/
#
include ../Base.mk

SUBDIRS := client server
TOPTARGETS := all clean

.PHONY: $(TOPTARGETS) $(SUBDIRS)

$(TOPTARGETS): $(SUBDIRS)
	
$(SUBDIRS):
	+$(MAKE) -C $@ $(MAKECMDGOALS)
