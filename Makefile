SRCDIR := src
DSTDIR := build
METASRC:= $(SRCDIR)/metadata.in.yaml
METATMP:= $(DSTDIR)/metadata.tmp.yaml
METADST:= $(DSTDIR)/metadata.yaml
SRCS   := $(sort $(wildcard $(SRCDIR)/??-*.md)) $(METADST)
TARGET := $(DSTDIR)/index.html
FLAGS  := --standalone --toc --number-sections

GITDATE := $(shell git show -s --format=%as)
GITDESC := $(shell git describe --dirty --always)
PDVER   := $(shell pandoc --version | head -n 1)


.PHONY: all rebuild meta clean

all: meta $(TARGET)

rebuild: clean all

# always run (.PHONY)
meta: $(DSTDIR)
	$(info [info] Create metadata)
# METASRC > METATMP
	sed -e 's/%%GITDATE%%/$(GITDATE)/g' $(METASRC) | \
	sed -e 's/%%GITDESC%%/$(GITDESC)/g' | \
	sed -e 's/%%PDVER%%/$(PDVER)/g' \
	> $(METATMP)
# if METADST != METATMP then METADST = METATMP
# [cmp] 0: no diff, 1: diff, 2: error (file not found)
	@cmp --silent $(METADST) $(METATMP); \
	if [ $$? -ne 0 ]; then \
		echo Update: $(METADST); \
		cp $(METATMP) $(METADST); \
	else \
		echo No update: $(METADST); \
	fi

$(TARGET): $(SRCS)
	$(info [info] Build)
	pandoc $(FLAGS) -o $@ $(SRCS)

$(DSTDIR):
	$(info [info] Dest Dir)
	mkdir -p $(DSTDIR)

clean:
	$(info [info] Clean)
	rm -rf $(DSTDIR)
