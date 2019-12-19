#!/bin/sh

emacs $1 --batch -f org-beamer-export-to-pdf --kill
