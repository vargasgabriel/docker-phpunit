build container phpunit 4.8.16

## build
`docker build -t phpunit/phpunit .`

## how to use
`docker run -v $(pwd):/app --rm phpunit/phpunit -c phpunit.xml`
