#!/bin/bash

me=$(echo $1 | tr '[:upper:]' '[:lower:]');

(curl -sL -N -H "Accept: text/event-stream" https://cowchat-bd025.firebaseio.com/users/$me/messages.json & cat /dev/tty) | ./consumer.sh $1

