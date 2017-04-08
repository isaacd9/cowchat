
from_user=$1;
room=$2;
echo "Hi $from_user, joining to $room! MOOOOOOOOOOOOOOOOOO";

room_join="$from_user has joined $room"
curl -s -X POST -d "{ \"from\": \"COWCHAT\", \"contents\": \"$room_join\" }" \
  "https://cowchat-bd025.firebaseio.com/rooms/$room/messages.json" > /dev/null

while read meth
do
  if [[ $meth =~ "put" ]]; then
    read next

    data=$(echo $next | cut -c 6- | jq ".data");
    from=$(echo $data | jq -r ".from");
    contents=$(echo $data | jq -r ".contents");

    if [[ $contents != "null" && $from != $from_user ]];  then
      say "moooooooooooooooooooooo"
      echo "$from:
      $contents" | cowsay -n
    fi
  elif [[ $meth =~ "@" ]]; then
    msg=$(echo $meth | cut -d "@" -f 2)

    echo "$from_user:
    $msg" | cowsay -n -f ./reverse.cow
    curl -s -X POST -d "{ \"from\": \"$from_user\", \"contents\": \"$msg\" }" \
      "https://cowchat-bd025.firebaseio.com/rooms/$room/messages.json" > /dev/null
  fi
done < /dev/stdin
