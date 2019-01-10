# Makefile

SRCTOP=..
include $(SRCTOP)/build/vars.mak

build: package
unittest:

PLUGIN_PATCH_LEVEL=2.0.3


systemtest: test-setup test-run

NTESTFILES  ?= systemtest

test-setup:
	$(EC_PERL) systemtest/setup.pl $(TEST_SERVER) $(PLUGINS_ARTIFACTS)

test-run: systemtest-run


include $(SRCTOP)/build/rules.mak
