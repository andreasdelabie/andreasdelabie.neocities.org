#!/bin/bash
source .env


rm -rf public/
hugo build --minify


args=()

for f in $(find ./public -type f); do
    remote="${f#./public/}"
    args+=(-F "$remote=@$f")
done

curl -u "$NEOCITIES_USER:$NEOCITIES_PASSWORD" "${args[@]}" 'https://neocities.org/api/upload'