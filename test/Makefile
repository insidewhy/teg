.SECONDARY:
.PHONY: default tbpeg teg variant choice joined lexeme sequence

default: variant teg maths choice joined lexeme sequence

debug     ?= 1
cwd       ?= ..
subdirs   ?= . detail beard beard/meta beard/string_util
comp_args := common.d -I..

include ../beard/Makefile
include ../beard/Makefile.test

update ?= ${u}

tbpeg: ${outpath}/tbpeg
teg: ${outpath}/teg
maths: ${outpath}/maths
variant: ${outpath}/variant
choice: ${outpath}/choice
joined: ${outpath}/joined
lexeme: ${outpath}/lexeme
sequence: ${outpath}/sequence
