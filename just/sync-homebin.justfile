# vim: set ft=make :

# List all tasks
default:
    @just --list

#rsync to all

#rsync to agedashi
sync-agedashi:
        scp -O * agedashi.lan:/var/services/homes/nlawren/.local/bin/

#rsync to all x64 servers


