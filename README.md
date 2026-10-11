# homebrew-tap

```bash
# list tap
brew tap-info concr/tap

# check upstream for new versions
brew livecheck --tap concr/tap
```

## Casks

* airport-konfigurator
* atomic-chat
* crystalrcm
* dmde
* dmde@beta
* m5burner
* makemkv-preservation
* notproton
* ultimate-lemmings
* ultimate-lemmings@slim
* xld-preservation

```bash
# show remote recipe 
brew cat --cask concr/tap/[CASK]

# strict check recipe
brew audit --cask --new concr/tap/[CASK]

# check upstream for new version
brew livecheck --cask concr/tap/[CASK]
```

## Formula

* TODO: DMDE console
  * https://dmde.com/download/dmde-4-4-6-846-mac64-con.dmg
  * https://dmde.com/download/dmde-4-5-0-849-beta-mac64-con.dmg
