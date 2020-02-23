#!/bin/bash

VERSION=2.26.0
PORT=336
WIREMOCK_DIR=$(cd -P -- "$(dirname -- "$0")" && pwd -P)/Wiremock
START=true
STOP=false

function usage
{
    echo "Usage:"
    echo "wiremock-setup.sh -k [-h]"
    echo
    echo "-k --kill - stop server"
    echo "-h --help - this screen"
}

while [ -n "$1" ]
do
    case $1 in
        -k | --kill )
            START=false
            STOP=true
            ;;
        -h | --help )
            usage
            exit
            ;;
        * )
            usage
            exit 1
    esac
    shift
done

if [ "$START" == true ]
then
    echo "Starting Wiremock on port $PORT from $WIREMOCK_DIR"
    if ! [ -f "Wiremock/wiremock-standalone-$VERSION.jar" ];
    then
        curl https://repo1.maven.org/maven2/com/github/tomakehurst/wiremock-standalone/$VERSION/wiremock-standalone-$VERSION.jar --output $WIREMOCK_DIR/wiremock-standalone-$VERSION.jar
    fi

    java -jar $WIREMOCK_DIR/wiremock-standalone-$VERSION.jar --verbose --port $PORT --root-dir $WIREMOCK_DIR --global-response-templating &
elif [ "$STOP" == true ]
then
    echo "Stopping Wiremock on localhost:$PORT"
    curl -X POST --data '' "http://localhost:$PORT/__admin/shutdown"
fi