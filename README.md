# grimoire

[![Build HTML and Push](https://github.com/yappy/grimoire/actions/workflows/pages.yaml/badge.svg)](https://github.com/yappy/grimoire/actions/workflows/pages.yaml)

Auto build: <https://yappy.github.io/grimoire/>

## Install mdBook

```sh
cargo install mdbook
cargo install mdbook-mermaid
```

### Update mdBook

```sh
cargo install cargo-update
cargo install-update --all
```

## Build

```sh
mdbook build
```

## VS Code plug-in

* markdownlint
* Markdown Preview Mermaid Support

VS Code Markdown Preview uses KaTeX.
mdbook uses MathJax.
I don't know when but now we can use `$ inline $` or `$$ block $$` notation
in mdbook for MathJax.
These notation will be parsed by VS Code preview as KaTeX code.
We can preview math formula if we use common notations for MathJax and KaTeX.

## Auto Build

See [pages.yaml](./.github/workflows/pages.yaml)

* `- uses: DavidAnson/markdownlint-cli2-action`
