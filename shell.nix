with (import <nixpkgs> {});

mkShell {
  buildInputs = [
    screenkey
    tig
    chromium
  ];
}
