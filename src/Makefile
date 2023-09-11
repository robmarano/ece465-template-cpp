#
# src/
#
include ../Base.mk

SUBDIRS := server client
TOPTARGETS := all clean

.PHONY: $(TOPTARGETS) $(SUBDIRS)

$(TOPTARGETS): $(SUBDIRS)
	
$(SUBDIRS):
	+$(MAKE) -C $@ $(MAKECMDGOALS)
