set dotenv-load := true

help:
    @just --list -f "{{ justfile() }}"

# Show the usage docs
show_docs:
    python -m mkdocs build -f docs\mkdocs.yml

# Build the epub
build:
    pytest tests {{ args }}

# format the markdown files
format +targets="src test":
    ruff format {{ targets }}
    ruff check --fix {{ targets }}

# read the output epub
read:
    goread
