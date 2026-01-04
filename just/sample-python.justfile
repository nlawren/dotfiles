# vim: ai et ts=4 sw=4
set dotenv-load := true

help:
    @just --list -f "{{ justfile() }}"

build_docs:
    python -m mkdocs build -f docs\mkdocs.yml
    python -m http.serve docs

runserver port="7070":
    flask run --port {{ port }}

test *args:
    pytest tests {{ args }}

format +targets="src test":
    ruff format {{ targets }}
    ruff check --fix {{ targets }}

clean_pyc:
    find . -name "*.pyc" -exec rm -f {} \;
    rmdir __pycache__
