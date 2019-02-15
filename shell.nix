with (import <nixpkgs> {});

let
  myTexlive = (texlive.combine {
    inherit (texlive) scheme-medium wrapfig ulem capt-of
    titlesec preprint enumitem paralist ctex environ
    beamer trimspaces zhnumber changepage framed
    fvextra minted upquote ifplatform xstring; });

in mkShell {
  buildInputs = [
    emacs
    gnumake
    myTexlive
  ];
}
