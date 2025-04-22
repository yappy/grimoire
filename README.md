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

## Auto Build

See [pages.yaml](./.github/workflows/pages.yaml)

* `- uses: DavidAnson/markdownlint-cli2-action`
