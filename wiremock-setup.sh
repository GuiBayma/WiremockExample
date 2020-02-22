#!/bin/bash

VERSION=2.26.0
PORT=336

if ! [ -f "Wiremock/wiremock-standalone-$VERSION.jar" ];
then
    curl https://repo1.maven.org/maven2/com/github/tomakehurst/wiremock-standalone/$VERSION/wiremock-standalone-$VERSION.jar --output Wiremock/wiremock-standalone-$VERSION.jar
fi

java -jar Wiremock/wiremock-standalone-$VERSION.jar --port $PORT --root-dir Wiremock --global-response-templating