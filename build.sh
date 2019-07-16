#!/bin/sh

emacs $1 --batch -f org-latex-export-to-pdf --kill
