;;; org-present -- Org present tweaks for this presentation
;;; Commentary:
;;; Code:

(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "/nix/var/nix/profiles/system/sw/bin/epiphany")

(eval-after-load "org-present"
  '(progn
     (add-hook 'org-present-mode-hook
               (lambda ()
                 (org-present-big)
                 (org-display-inline-images)
                 (org-present-hide-cursor)
                 (org-present-read-only)))
     (add-hook 'org-present-mode-quit-hook
               (lambda ()
                 (org-present-small)
                 (org-remove-inline-images)
                 (org-present-show-cursor)
                 (org-present-read-write)))))

;; org-present.el ends here
