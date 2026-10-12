# homebrew-tap

## General commands

```bash
# list tap
brew tap-info concr/tap
```

## Update version

```bash
# check upstream for new versions
brew livecheck --tap concr/tap

# if there is a new version, change it in the .rb file and run:
sh update-cask-sha.sh Casks/[CASK].rb
```

## Casks

* airport-konfigurator
* atomic-chat
* crystalrcm
* dmde
* dmde@beta
* fs-uae@alpha
* m5uploader
* makemkv-preservation
* newshosting
* notproton
* ultimate-lemmings
* ultimate-lemmings@slim
* xact-preservation
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
