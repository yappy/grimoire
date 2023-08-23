SRCDIR := src
DSTDIR := build
SRCS   := $(sort $(wildcard $(SRCDIR)/??-*.md))
META   := $(SRCDIR)/metadata.yaml
TARGET := $(DSTDIR)/index.html
FLAGS  := --standalone --toc --number-sections

GITDATE := $(shell git show -s --format=%as)
GITDATE := $(shell git describe --dirty --always)


.PHONY: all rebuild clean

all: $(TARGET)

rebuild: clean all

$(TARGET): $(DSTDIR) $(SRCS) $(META)
	pandoc $(FLAGS) -o $@ $(SRCS) $(META)
	pandoc $(FLAGS) -o build/book.pdf $(SRCS) $(META)

$(DSTDIR):
	mkdir -p $(DSTDIR)

clean:
	rm -rf $(DSTDIR)
