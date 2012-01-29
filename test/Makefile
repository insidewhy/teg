.SECONDARY:
.PHONY: default tbpeg teg variant choice joined force

default: variant teg maths choice joined

debug     ?= 1
cwd       ?= ..
subdirs   ?= . detail beard
comp_args := common.d

include ../beard/Makefile
include ../beard/Makefile.test

update ?= ${u}

tbpeg: ${outpath}/tbpeg
teg: ${outpath}/teg
maths: ${outpath}/maths
variant: ${outpath}/variant
choice: ${outpath}/choice
joined: ${outpath}/joined
