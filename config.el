;;; config -- Emacs config to set up org-mode configs for pdf exports

;;; Commentary:
;;; Code:

(require 'use-package)

(use-package org)
(use-package ox-beamer)
(use-package ox-latex)
(use-package ox-gfm
  :config
  (progn
    (eval-after-load "org" '(require 'ox-gfm nil t))

    ;; Syntax highlight in babel exports (has extra env requirements)
    (setq org-export-allow-bind-keywords t)
    (setq org-latex-listings 'minted)
    (add-to-list 'org-latex-packages-alist '("" "minted" "listings"))

    (setq org-latex-pdf-process
          '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
            "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
            "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))))

;;; config.el ends here
