#!/bin/sh

set -e

username="$1"
target="$2"

if test -z "$username"; then
	echo "Usage: `basename $0` username [target]" 1>&2
	exit 5
fi

if test -n "$target"; then
	cd "$target"
fi

for remote in $(
	curl -s "http://github.com/api/v2/yaml/repos/show/$username" |
	grep ' :url: ' |
	awk '{print $2}'
); do
	git clone "$remote"
done
