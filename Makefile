ALL_SOURCES := $(wildcard source/*.tex)

all: title paper figures

title: minipw/titlepage.tex
	tectonic minipw/titlepage.tex -o .

paper: main.tex $(ALL_SOURCES)
	tectonic main.tex

figures:
	asy -cd=illustrations/montecarlo random_seq.asy
	asy -cd=illustrations/montecarlo uniform_seq.asy
	asy -cd=illustrations/montecarlo halton_seq.asy
	asy -cd=illustrations/montecarlo hammersley_seq.asy

clean:
	rm -f main.pdf titlepage.pdf

.PHONY: all clean
