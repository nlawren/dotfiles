# vim: ai et ts=4 sw=4
set dotenv-load := true

# list all tasks and help text
help:
    @just --list -f "{{ justfile() }}"

#rsync to all

#rsync to agedashi
sync-agedashi:
    rsync -av ~/.local/store/local.bin/aarch64/ agedashi.lan:/var/services/homes/nlawren/.local/bin/

#rsync to all x64 servers


