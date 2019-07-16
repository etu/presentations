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
    ;
  });

in mkShell {
  buildInputs = [
    emacs
    gnumake
    myTexlive
  ];
}
