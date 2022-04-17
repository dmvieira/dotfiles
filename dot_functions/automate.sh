#!/usr/bin/env bash

# ifttt functions
function notifyme {
    if [ $# -eq 0 ]
    then
        dot_help notifyme
        return 1
    fi
    curl -X POST -H "Content-Type: application/json" -d "$1" "https://maker.ifttt.com/trigger/notifications/json/with/key/${IFTTT_API_KEY}"

}

function notifymessage {
    if [ $# -eq 0 ]
    then
        dot_help notifymessage
        return 1
    fi
    notifyme "{\"message\": \"$1\"}"
}
