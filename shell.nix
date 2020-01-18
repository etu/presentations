with (import <nixpkgs> {});

let
  myTexlive = (texlive.combine {
    inherit (texlive) scheme-basic
      # Needed on top of scheme-basic
      beamer ec etoolbox eurosym translator ulem

      # Needed on top of scheme-small
      cm-super

      # Needed on top of scheme-medium
      capt-of wrapfig

      # Packages needed for supporting colored code highlighting
      minted fvextra fancyvrb upquote lineno xstring framed float
    ;
  });

  # Get emacs with some extra packages
  myEmacs = emacsWithPackages(epkgs: with epkgs; [
    org
    ox-gfm
    use-package
  ]);

  # Needed for pdflatex export whith code highlighting
  myPython = python3.withPackages(ps: with ps; [
    pygments
  ]);

in mkShell {
  buildInputs = [
    myEmacs
    myPython
    myTexlive
  ];
}
