.PHONY: help build run test valid doc fake dev server

APP_NAME       = template-halogen-tailwind

# Versioning
VERSION        = $(shell git describe --abbrev=0 --tags)
COMMIT_HASH    = $(shell git log -n 1 --pretty="format:%h")
COMMIT_DATE    = $(shell git log -n 1 --pretty="format:%cd")

# Env
BUILD          = dist
MKFILE        := $(abspath $(lastword $(MAKEFILE_LIST)))
CURDIR        := $(dir $(MKFILE))


## help: prints this help message
help:
	@echo "Usage: \n"
	@sed -n 's/^##//p' Makefile | column -t -s ':' |  sed -e 's/^/ /'
	@echo ""


## build: production application building
build: clean
	npm run build:spago
	npm run build:webpack


## clean: clean temporary files
clean:
	if [ -d $(BUILD) ]; then  rm -rf $(BUILD); fi


## test: execute unit tests
test:
	npm run test


## valid: execute validation tests
docker:
	docker build -f Dockerfile.build --rm \
		--build-arg VERSION="$(VERSION)" \
		--build-arg GIT_DATE="$(COMMIT_DATE)" \
		--build-arg GIT_COMMIT="$(COMMIT_HASH)" \
		--tag $(APP_NAME):$(VERSION) .

	docker run --rm -p $(SDEV_PORT):80 $(APP_NAME):$(VERSION)


## dev: setup environment
env:
	stack install dhall-lsp-server
	npm install
	npm run install:spago


## dev: run the development server
dev:
	tmux \
		new   			"npm run build:webpack:watch; sleep 10" ';' \
		split -p 80 "npm run build:spago:watch; sleep 10"


## dev-webpack: run the webpack development server
dev-webpack:
	npm run build:webpack:watch

## dev-spago: run the spago development server
dev-spago:
	npm run build:spago:watch