while read meth
do
  if [[ $meth =~ "put" ]]; then
    read next

    data=$(echo $next | cut -c 6- | jq ".data");
    from=$(echo $data | jq -r ".from");
    contents=$(echo $data | jq -r ".contents");

    echo "$from:
    $contents" | cowsay -n
  fi
done < "${1:-/dev/stdin}"
