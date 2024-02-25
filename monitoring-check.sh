#!/usr/bin/env bash

base=/opt/monitoring

mkdir -p "$base"
pushd "$base" || exit 1

if ! git status
then
    git clone https://github.com/briansalehi/monitoring.git
fi

git switch main

git pull origin main

interfaces=( $(ip link | sed -n '/^[0-9]\+:/s/^[0-9]\+:\s\+\([a-z0-9]\+\):.*/\1/p' | grep -v 'lo') )

for inet in "${interfaces[@]}"
do
    echo "$inet"
done
