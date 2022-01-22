VERSION ?= latest
TAGS ?= latest
TAG_LIST = $(subst :, ,$(TAGS))

.PHONY alpine-image:
alpine-image:
	docker build --build-arg VERSION=$(VERSION) -f build/alpine/Dockerfile -t enix223/awesome-openresty:$(VERSION) .
	for tag in $(TAG_LIST) ; do \
		docker tag enix223/awesome-openresty:$(VERSION) enix223/awesome-openresty:$$tag; \
	done


.PHONY alpine-fat:
alpine-fat:
	make VERSION=1.19.9.1-5-alpine-fat TAGS=1.19.9.1-5-alpine-fat:1.19.9.1-alpine-fat:alpine-fat alpine-image


.PHONY alpine:
alpine:
	make VERSION=1.19.9.1-5-alpine TAGS=1.19.9.1-5-alpine:1.19.9.1-alpine:alpine alpine-image


.PHONY push:
push:
	for tag in $(TAG_LIST) ; do \
		docker push enix223/awesome-openresty:$$tag; \
	done


.PHONY push-alpine:
push-alpine:
	make VERSION=1.19.9.1-5-alpine-fat TAGS=1.19.9.1-5-alpine-fat:1.19.9.1-alpine-fat:alpine-fat:1.19.9.1-5-alpine:1.19.9.1-alpine:alpine push


.PHONY runalpine:
runalpine:
	docker run -it -d --name awesome-openresty-test \
		-p 80:80 \
		-v $(shell pwd)/test/:/var/www/public \
		-v $(shell pwd)/test/conf.d/:/etc/nginx/conf.d/ \
		enix223/awesome-openresty:alpine


.PHONY runalpine-fat:
runalpine-fat:
	docker run -it -d --name awesome-openresty-test \
		-p 80:80 \
		-v $(shell pwd)/test/:/var/www/public \
		-v $(shell pwd)/test/conf.d/:/etc/nginx/conf.d/ \
		enix223/awesome-openresty:alpine-fat
