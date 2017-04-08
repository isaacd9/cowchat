
from_user=$1;
echo "Hi $from_user! MOOOOOOOOOOOOOOOOOO";

while read meth
do
  if [[ $meth =~ "put" ]]; then
    read next

    data=$(echo $next | cut -c 6- | jq ".data");
    from=$(echo $data | jq -r ".from");
    contents=$(echo $data | jq -r ".contents");

    if [[ $contents != "null" ]];  then
      echo "$from:
      $contents" | cowsay -n
    fi
  elif [[ $meth =~ "@" ]]; then
    msg=$(echo $meth | cut -d "@" -f 2)
    to_user=$(echo $msg | cut -d " " -f 1 | tr '[:upper:]' '[:lower:]')
    contents=$(echo $msg | cut -d " " -f 2-)

    echo "$from_user:
    $contents" | cowsay -n -f ./reverse.cow
    curl -s -X POST -d "{ \"from\": \"$from_user\", \"contents\": \"$contents\" }" \
      "https://cowchat-bd025.firebaseio.com/users/$to_user/messages.json" > /dev/null
  fi
done < /dev/stdin
