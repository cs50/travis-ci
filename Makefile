default: run

build:
	docker build -t cs50/travis-ci .

rebuild:
	docker build --no-cache -t cs50/travis-ci .

run:
	docker run --interactive --rm --tty --volume "$(PWD)":/root cs50/travis-ci
