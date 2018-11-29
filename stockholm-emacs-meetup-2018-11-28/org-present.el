;;; org-present -- Org present tweaks for this presentation
;;; Commentary:
;;; Code:

(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "/nix/store/l31807cdd8fickj9mn8cxyzyx5yil04q-chromium-70.0.3538.102/bin/chromium")

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
