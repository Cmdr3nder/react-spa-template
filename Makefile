PHONY: serve
serve:
	python -m http.server 8080

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

