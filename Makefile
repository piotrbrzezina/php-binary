#!/usr/bin/env make

docker-build-image:
	docker build --no-cache --file ./Dockerfile --tag kazik.aws.tshdev.io/tsh/docker/php:latest --build-arg APCU_VERSION=${APCU_VERSION}  --build-arg PHP_VERSION=${PHP_VERSION} .

docker-push-image:
	docker tag kazik.aws.tshdev.io/tsh/docker/php:latest kazik.aws.tshdev.io/tsh/docker/php:${PHP_VERSION}-latest
	docker tag kazik.aws.tshdev.io/tsh/docker/php:latest kazik.aws.tshdev.io/tsh/docker/php:${PHP_VERSION}-`date +'%y.%m.%d'`
	docker push kazik.aws.tshdev.io/tsh/docker/php:${PHP_VERSION}-latest
	docker push kazik.aws.tshdev.io/tsh/docker/php:${PHP_VERSION}-`date +'%y.%m.%d'`