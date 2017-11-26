ALL_SOURCES := $(wildcard source/*.tex)

all: title paper

title: minipw/titlepage.tex
	tectonic minipw/titlepage.tex -o .

paper: main.tex $(ALL_SOURCES)
	tectonic main.tex

clean:
	rm -f main.pdf titlepage.pdf

.PHONY: all clean
