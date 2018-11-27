with (import <nixpkgs> {});

mkShell {
  buildInputs = [
    screenkey
  ];
}
