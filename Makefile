.PHONY: test

O ?= ${cwd}/.obj

dmd := $(if ${gdc},gdmd,dmd)
subdirs ?= . detail beard
libfiles ?= $(foreach d,$(addprefix ${cwd}/,${subdirs}),$(wildcard ${d}/*.d))

test:
	${MAKE} -C test
