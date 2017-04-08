#!/bin/bash

me=$(echo $1 | tr '[:upper:]' '[:lower:]');
room=$(echo $2 | tr '[:upper:]' '[:lower:]');

(curl -sL -N -H "Accept: text/event-stream" https://cowchat-bd025.firebaseio.com/rooms/$room/messages.json & cat /dev/tty) | ./consumer.sh $me $room

