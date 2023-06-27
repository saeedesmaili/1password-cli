for id in $(op item list --format=json | jq -r '.[] | select(.id != null) | .id'); do
  item=$(op item get $id --format=json)

  if [[ $item != null ]]; then
    fields=$(echo $item | jq -r '.fields')

    if [[ $fields != null ]]; then
      username=$(echo $fields | jq -r '.[] | select(.label=="username").value')

      if [[ $username == http* ]]; then
        op item delete $id --archive
        echo "$id deleted"
      fi
    fi
  fi
done