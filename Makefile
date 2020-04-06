.PHONY: build link output/Main/index.js

build: | node_modules
	npx spago build

node_modules:
	npm install
