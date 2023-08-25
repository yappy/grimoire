SRCDIR := src
DSTDIR := build
METASRC:= $(SRCDIR)/metadata.in.yaml
MERADST:= $(DSTDIR)/metadata.yaml
SRCS   := $(sort $(wildcard $(SRCDIR)/??-*.md)) $(MERADST)
TARGET := $(DSTDIR)/index.html
FLAGS  := --standalone --toc --number-sections

GITDATE := $(shell git show -s --format=%as)
GITDESC := $(shell git describe --dirty --always)
PDVER   := $(shell pandoc --version | head -n 1)


.PHONY: all rebuild $(MERADST) clean

all: $(TARGET)

rebuild: clean all

# always run (.PHONY)
$(MERADST): $(DSTDIR)
	sed -e 's/%%GITDATE%%/${GITDATE}/g' $(METASRC) | \
sed -e 's/%%GITDESC%%/${GITDESC}/g' | \
sed -e 's/%%PDVER%%/${PDVER}/g' \
> $(MERADST)

$(TARGET): $(SRCS) $(META)
	pandoc $(FLAGS) -o $@ $(SRCS) $(META)

$(DSTDIR):
	mkdir -p $(DSTDIR)

clean:
	rm -rf $(DSTDIR)
