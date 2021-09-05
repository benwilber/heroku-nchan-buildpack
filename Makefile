NGINX_VERSION ?= 1.21.2
NCHAN_VERSION ?= 1.2.10
# NGINX_VERSION ?= 1.14.2
# NCHAN_VERSION ?= 1.2.10

build: build-heroku-18 build-heroku-20

build-heroku-18:
	@echo "Building Nchan in Docker for heroku-18 ..."
	@docker run -v $(shell pwd):/buildpack -w /buildpack --rm -it \
		 -e "STACK=heroku-18" -e "NGINX_VERSION=$(NGINX_VERSION)" -e "NCHAN_VERSION=$(NCHAN_VERSION)" \
		heroku/heroku:18-build bin/build /buildpack/dist/nchan-heroku-18.tar.gz

build-heroku-20:
	@echo "Building Nchan in Docker for heroku-20 ..."
	@docker run -v $(shell pwd):/buildpack -w /buildpack --rm -it \
		 -e "STACK=heroku-20" -e "NGINX_VERSION=$(NGINX_VERSION)" -e "NCHAN_VERSION=$(NCHAN_VERSION)" \
		heroku/heroku:20-build bin/build /buildpack/dist/nchan-heroku-20.tar.gz

shell-heroku-18:
	@echo "Start a Docker shell for heroku-18 ..."
	@docker run -v $(shell pwd):/buildpack --rm -it -e "STACK=heroku-18" -w /buildpack heroku/heroku:18-build bash


shell-heroku-20:
	@echo "Start a Docker shell for heroku-20 ..."
	@docker run -v $(shell pwd):/buildpack --rm -it -e "STACK=heroku-20" -w /buildpack heroku/heroku:20-build bash

release:
	git commit -a -m "Rebuilding stacks"
	git push origin master
