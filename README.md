# Repo of presentation slides I've held in public
All the presentations are written in org-mode and then exported to beamer
slides using texlive.

All the deps and configuration needed to build these presentations are
embedded within the repository and you can use the nix flake to build
any presentation within the repo by typing something like:
```sh
nix build .#directory-name
```

Then you get symlink named `result` that leads to a PDF.
