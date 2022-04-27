## Makefile

all:
	cd functions && npm install && cd - && firebase emulators:start

unit_tests:
	echo "No test to execute"

.PHONY:	all unit_tests%    