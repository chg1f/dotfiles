# Quick Start

## Environment

```bash
export GITHUB_USERNAME=chg1f
```

## Initialization

### Client Side

```bash
sh -c "$(curl -fsSL get.chezmoi.io)" -- init --ssh $GITHUB_USERNAME
```

### Server Side

```bash
sh -c "$(curl -fsSL get.chezmoi.io)" -- init --one-shot $GITHUB_USERNAME
```

## Daily Operation

### Apply

```bash
chezmoi scripts --fetch --apply
```

### Commit

```bash
chezmoi scripts --commit --upload
```
