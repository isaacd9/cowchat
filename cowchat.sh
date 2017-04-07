#!/bin/bash

curl -sL -N -H "Accept: text/event-stream" https://cowchat-bd025.firebaseio.com/users/isaac/messages.json | ./consumer.sh

