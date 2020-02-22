#!/usr/bin/env bash
#
# A small script for sending notifications via Pushover

API_URL="https://api.pushover.net/1/messages.json"

help_text=$"Usage: pushover -m=message [options]

Short Options:			Full Options:
-m=\"hello, world!\"		--message=\"hello, world!\"
-t=\"this is a test\"		--title=\"this is a test\"
-o=123456789			--token=123456789
-u=123456789			--user=123456789"

load_conf () {
	CONF_FILE="$HOME/.snarfblat.conf"
	if [ -f "${CONF_FILE}" ]; then
		. "${CONF_FILE}"
	else
		echo "${CONF_FILE} does not exist"
		exit 1
	fi
}

setup_params () {
	while [ "$1" != "" ]; do
	    PARAM=`echo $1 | awk -F= '{print $1}'`
	    VALUE=`echo $1 | awk -F= '{print $2}'`
	    case $PARAM in
	        -h|--help)
				echo "${help_text}"
	            exit
	            ;;
	        -m|--message)
	            MESSAGE=$VALUE
	            ;;
	        -t|--title)
	            TITLE=$VALUE
	            ;;
	        -o|--token)
	            TOKEN=$VALUE
	            ;;
	        -u|--user)
	            USER=$VALUE
	            ;;
	        *)
	            echo "Unknown parameter \"$PARAM\""
	            exit 1
	            ;;
	    esac
	    shift
	done
}

send_request () {
	params="token=${SNARFBLAT_TOKEN}&user=${SNARFBLAT_USER}&title=${TITLE}&message=${MESSAGE}"
	result=`curl -s -d "$params" $API_URL`
	echo $result
}

parse_response () {
	echo "${1}" | python -m json.tool | awk -F'"' '/status/{print $4}'
}

# load ~/.snarfblat.conf
load_conf
# parse and set params
setup_params "$@"
# send the request to pushover
response=$(send_request)
# spit out response
echo "${response}"