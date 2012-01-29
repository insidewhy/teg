.SECONDARY:
.PHONY: default tbpeg teg variant choice joined force

debug ?= 1

update ?= ${u}
outpath := output
cwd ?= ..

default: variant teg maths choice joined

-include ../Makefile

tbpeg: ${outpath}/tbpeg
teg: ${outpath}/teg
maths: ${outpath}/maths
variant: ${outpath}/variant
choice: ${outpath}/choice
joined: ${outpath}/joined
force:

${outpath}/%: ${O}/% force
	@mkdir -p ${outpath}
	@./$< | tee $@.new
	@$(if ${update},rm -f $@,true)
	@if [ ! -f $@ ] ; then \
		echo "new test $(subst ${outpath}/,,$@)"; \
		mv $@.new $@; \
	elif diff $@ $@.new ; then \
		echo "test $(subst ${outpath}/,,$@) passed"; \
		rm $@.new; \
	else \
		echo "test $(subst ${outpath}/,,$@) failed"; \
	fi

${O}/%: %.d ${libfiles}
	@mkdir -p ${O}
	${dmd} -I../.. ${comp_args} -od${O} -of$@ common.d $^

