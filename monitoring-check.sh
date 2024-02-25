#!/usr/bin/env bash

base=/opt/projects/monitoring

mkdir -p "$base"
pushd "$base" || exit 1

if ! git status
then
    git clone https://github.com/briansalehi/monitoring.git
fi

if git pull origin main
then
    rm -rf build
    git switch main
    cp monitoring /usr/local/bin
    #cmake -S . -B build -D CMAKE_BUILT_TYPE=Release
    #cmake --build build --parallel $(nproc) --target all
    #cmake --install build
fi

interfaces=( $(ip link | sed -n '/^[0-9]\+:/s/^[0-9]\+:\s\+\([a-z0-9]\+\):.*/\1/p' | grep -v 'lo') )

for inet in "${interfaces[@]}"
do
    echo "$inet"
done
