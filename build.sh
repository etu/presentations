#!/bin/sh

# Resolve path to config file
configel=$(realpath $(dirname $(echo $0)))"/config.el"

# Build PDF
emacs $1 --load=$configel --batch -f org-beamer-export-to-pdf --kill
