#!/bin/bash
deactivate 2>/dev/null || true
mkdir -p ~/open-interpreter
cd ~/open-interpreter
python3 -m venv open-interpreter
~/open-interpreter/open-interpreter/bin/python -m pip install --upgrade pip
~/open-interpreter/open-interpreter/bin/python -m pip install open-interpreter
