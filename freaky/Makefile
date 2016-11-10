
SHELL   := bash
THISDIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
DESTDIR ?= $(THISDIR)/build

SUBDIRS := pgcomparator
SUBDIRS += queryator
SUBDIRS += raider
SUBDIRS += s3grooming

.PHONY: clean
clean:
	touch clean.ok ; rm -rf *.ok isolate* target*

# Tearing apart per:
#
#   http://blogs.atlassian.com/2014/04/tear-apart-repository-git-way/
#
.PHONY: isolate $(SUBDIRS:%=isolate-%)
isolate: $(SUBDIRS:%=isolate-%)
$(SUBDIRS:%=isolate-%): isolate-%: isolate-%.ok
$(SUBDIRS:%=isolate-%.ok): isolate-%.ok:
	rm -rf isolate-$*
	git clone git@github.com:ProsperWorks/ALI.git isolate-$*
	cd isolate-$* ; git checkout major_2016_11_queso
	cd isolate-$* ; git remote rm origin
	cd isolate-$* ; git filter-branch --subdirectory-filter $*/ -- master
	touch $@

# Merging together per:
#
#   https://saintgimp.org/2013/01/22/merging-two-git-repositories-into-one-repository-without-losing-file-history/
#
.PHONY: init-target
init-target: init-target.ok
init-target.ok:
	rm -rf target
	mkdir target
	cd target && git init && echo foo > deleteme.txt && git add .
	cd target && git commit -m "Initial dummy commit."
	touch $@
.PHONY: merge $(SUBDIRS:%=merge-%)
merge: $(SUBDIRS:%=merge-%)
$(SUBDIRS:%=merge-%): merge-%: merge-%.ok
$(SUBDIRS:%=merge-%.ok): merge-%.ok: init-target.ok isolate-%.ok
	cd target ; git remote rm $* ; git remote add -f $* file://$(THISDIR)/isolate-$*
	cd target ; git remote show
	touch $@
