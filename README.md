
# platform manifest for postmarketOS's anbox image

have a look at https://gitlab.com/postmarketOS/anbox-image-make/
for the build instructions.

please don't rely on the commit hash in this repo, as they will be
rebased.

## `pin-this-tree.sh`

this tool is used to maintain this repository: it pins every git tree
to its currently checked out commit.

How to pin the commits:

1. in this repo, get back to the original, non-pinned,
   version of the manifest
```sh
git checkout unpinned default.xml
```

2. get the android source
```sh
cd anbox-image-make # (that's the git repo above)
make fetch && date=$(date -u +%s) # get the latest version of the source
```

3. pin the versions and create the tarball
```sh
cd source # anbox-image-make/source, or wherever you did put it
repo forall -c '~/platform_manifests/pin-this-tree.sh'
tar -czf anbox-image-$date.tar.gz *
```

then go back to this repository, `git commit default.xml -m "pin to $date"`, `git push` and upload the tarball.

## Note for maintainers

When not pushing a change that pin commits, remember to update the unpinned tag: `git tag -f unpinned`
