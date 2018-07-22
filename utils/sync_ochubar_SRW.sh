#!/bin/bash

# commit 6af042462fa2e5d15548836bec784ff82b888f7d (HEAD -> master, origin/master, origin/HEAD)
# Author: Tchoubar <chubar@bnl.gov>
# Date:   Sun Nov 19 03:40:50 2017 -0500
# 
#     misc. updates/fixes in C++ and Python parts

master=$HOME/src/ochubar/SRW
fork=$HOME/src/radiasoft/SRW-light
idir=$PWD

cd $master

# commit='6af042462fa2e5d15548836bec784ff82b888f7d'
commit=$(git rev-parse HEAD)
list_of_files=$(git show --name-status --pretty=format: $commit)

for i in $(seq 1 $(echo "$list_of_files" | wc -l)); do
    line=$(echo "$list_of_files" | head -$i | tail -1)
    stat=$(echo $line | awk -F' ' '{print $1}')
    file=$(echo $line | awk -F' ' '{print $2}')
    echo ""
    if [ "$stat" == "D" ]; then
        echo "File: ===$file==="
        echo "Stat: ===$stat==="
        cd $fork
	git rm $file
	cd $master
    else
        cp -v $master/$file $fork/$file
    fi 
done

