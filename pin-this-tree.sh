#!/bin/sh
# pin every repo to the current checked out commit
# this script assumes no commit is already pinned

# tested with GNU and Busybox sed.

if [ -n "$1" ]; then
	manifest="$1"
else
	dir="$(realpath "$(dirname "$0")")"
	if [ -z "$dir" ]; then
		dir=.
	fi
	manifest="$dir"/default.xml
fi

if ! [ -f "$manifest" ]; then
	echo "could not find $manifest. make sure to cd" \
	     "in the platform_manifest directory that contains it"
	exit 1
fi

commit="$(git rev-parse HEAD)"
path="$REPO_PATH"

sed "$(cat <<EOT
	# find the line that references this path
	\| path="$path"|    s| />| revision="$commit" />|
	                    # … and append the desired commit
EOT
)" "$manifest" -i
