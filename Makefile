#!/usr/bin/env make

docker-build-image:
	docker build --no-cache --file ./Dockerfile --tag piotrbrzezina/php-binary:latest --build-arg APCU_VERSION=${APCU_VERSION}  --build-arg PHP_VERSION=${PHP_VERSION} .

docker-push-image:
	docker tag piotrbrzezina/php-binary:latest piotrbrzezina/php-binary:${PHP_VERSION}-latest
	docker tag piotrbrzezina/php-binary:latest piotrbrzezina/php-binary:${PHP_VERSION}-`date +'%y.%m.%d'`
	docker push piotrbrzezina/php-binary:${PHP_VERSION}-latest
	docker push piotrbrzezina/php-binary:${PHP_VERSION}-`date +'%y.%m.%d'`