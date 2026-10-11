# homebrew-tap

```bash
# list tap
brew tap-info concr/tap

# check versions
brew livecheck --tap concr/tap
```

## Casks

* airport-konfigurator
* atomic-chat
* crystalrcm
* makemkv-preservation
* notproton
* ultimate-lemmings
* ultimate-lemmings@slim
* xld-preservation

```bash
# show remote recipe 
brew cat --cask concr/tap/[CASK]

# lint remote recipe
brew audit --cask --strict concr/tap/[CASK]

# check upstream for new version
brew livecheck --cask concr/tap/[CASK]
```

## Formula

### TBD

TBD
