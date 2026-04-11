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

```bash
just c p f a x
```
