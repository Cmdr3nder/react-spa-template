# Prepare for recursive calls, like watch-build
# Adapted from https://stackoverflow.com/a/27132934
THIS_FILE := $(lastword $(MAKEFILE_LIST))

PHONY: serve
serve:
	npx serve -l 8080 build

PHONY: clean-dependencies
clean-dependencies:
	rm -rf node_modules

PHONY: install
install: clean-dependencies
	npm ci

PHONY: upgrade
upgrade: clean-dependencies
	rm package-lock.json
	npm install

PHONY: clean-build
clean-build:
	rm -rf build

PHONY: core-build
core-build:
	npx esbuild --bundle src/index.jsx --outfile=build/app.js
	cp src/index.html build/

PHONY: build
build: clean-build core-build

PHONY: watch-build
watch-build: clean-build
	find src/ -type f | entr $(MAKE) -f $(THIS_FILE) core-build
