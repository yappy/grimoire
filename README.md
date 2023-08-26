# grimoire

[![Build HTML and Push](https://github.com/yappy/grimoire/actions/workflows/pages.yaml/badge.svg)](https://github.com/yappy/grimoire/actions/workflows/pages.yaml)

Auto build (branch: pages, location: docs/index.html):
<https://yappy.github.io/grimoire/>

## Install Pandoc

```bash
sudo apt install pandoc
```

## Build

```bash
make
```

```bash
# other targets
make clean
make rebuild
```

## VS Code plug-in

* markdownlint

## Auto Build

`docs/` dir on `pages` branch is configured for github pages.
It will be automatically published as <https://yappy.github.io/grimoire/> .

On push to `main` branch, GitHub Actions will be automatically triggered.
(see `.guthub/workflows/` dir)
The action will do:

1. Checkout the latest `pages` branch.
1. Merge from `main`.
1. Build and update `docs/`.
1. Git commit and push.

### Workflow Permission Error in Auto Build

If contents in `.guthub/workflows/` were changed on `main`,
merge and push will be failed by permission error.

> (refusing to allow a GitHub App to create or update workflow
> `.github/workflows/pages.yaml` without `workflows` permission)

Auto generated access token (`$GITHUB_TOKEN`) for action doesn't have
`workflows` permission to modify files in `.guthub/workflows/` dir.
This permission can be configured with `permissions` section in yaml file,
but `workflows` permission cannot be granted even if `write-all` is specified.

I suppose it is reasonable because it is denger to allow actions to modify
theirselves.
Therefore, if auto build is failed by `workflows` permission error,
merge `main` branch into `pages` branch manually by yourself.

```sh
git switch pages
git merge --no-ff main
git push
```
