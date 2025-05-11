{
  description = "etu repository of presentations";

  inputs = {
    flake-utils.url = "flake-utils";
  };

  outputs = {
    flake-utils,
    self,
    nixpkgs,
    ...
  } @ inputs: let
  in
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};

      buildEmacsBeamerSlides = name: slideDir: slideName:
        pkgs.stdenv.mkDerivation {
          inherit name;

          src = slideDir;

          nativeBuildInputs = [
            # Build emacs with extra packages for beamer exports
            (pkgs.emacs.pkgs.withPackages (epkgs:
              with epkgs; [
                org
                ox-gfm
                use-package
              ]))

            # Build python with extra packages for code highlights
            (pkgs.python3.withPackages (p:
              with p; [
                pygments
              ]))

            # Build texlive with extra packages for beamer exports
            (pkgs.texlive.combine {
              inherit
                (pkgs.texlive)
                scheme-basic
                beamer
                capt-of
                catchfile
                cm-super
                ec
                etoolbox
                eurosym
                fancyvrb
                float
                framed
                fvextra
                lineno
                minted
                translator
                ulem
                upquote
                wrapfig
                xstring
                ;
            })
          ];

          buildPhase = let
            emacsBeamerConfig = pkgs.writeText "config.el" ''
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
            '';
          in ''
            emacs ${slideName} --load=${emacsBeamerConfig} --batch -f org-beamer-export-to-pdf --kill
          '';

          installPhase = ''
            cp presentation.pdf $out
          '';
        };
    in {
      # Specify a formatter for "nix fmt ."
      formatter = pkgs.alejandra;

      # Build presentations with org-mode and beamer
      packages = {
        cfp-36c3-lightningtalk-exwm = buildEmacsBeamerSlides "cfp-36c3-lightningtalk-exwm" ./cfp-36c3-lightningtalk-exwm "presentation.org";
        oslo-nixos-meetup-2020-02-22 = buildEmacsBeamerSlides "oslo-nixos-meetup-2020-02-22" ./oslo-nixos-meetup-2020-02-22 "presentation.org";
        stockholm-emacs-meetup-2018-11-28 = buildEmacsBeamerSlides "stockholm-emacs-meetup-2018-11-28" ./stockholm-emacs-meetup-2018-11-28 "presentation.org";
        stockholm-emacs-meetup-2019-03-20 = buildEmacsBeamerSlides "stockholm-emacs-meetup-2019-03-20" ./stockholm-emacs-meetup-2019-03-20 "presentation.org";
      };
    });
}
