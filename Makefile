.PHONY: install build

VENV = ./venv
ACTIVATE = . $(VENV)/bin/activate
PIP = $(VENV)/bin/pip

install:
	python3 -m venv ${VENV}
	${PIP} install -U pip setuptools wheel
	${PIP} install -r requirements-build.txt
	${PIP} install -r requirements-lint.txt

build:
	# Like in .github/actions/build-dist/action.yml
	rm dist py/jupyterlite/dist -rf
	${ACTIVATE} && doit setup:js
	${ACTIVATE} && doit -n4 build:js*
	${ACTIVATE} && doit -n4 build:py*
	${ACTIVATE} && doit dist
