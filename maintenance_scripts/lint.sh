#!/usr/bin/env bash
set -euo pipefail

echo Flake8:
flake8 pikaur pikaur.py pikaur_test

echo PyLint...
python -m pylint --jobs="$(nproc)"  pikaur.py pikaur pikaur_test --score no

echo MyPy:
env MYPYPATH=./maintenance_scripts/mypy_stubs python -m mypy pikaur.py pikaur_test

echo Vulture:
./maintenance_scripts/vulture.sh

echo Shellcheck...
./maintenance_scripts/shellcheck.sh

echo '== GOOD!'
