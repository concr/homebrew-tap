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

## Helpful commands

```bash
# get bundleid
mdls -name kMDItemCFBundleIdentifier -r "/Applications/Insert App Name Here.app"
```

```bash
# find all folder / files for zap
find ~/Library /Library /private/var/folders -iname "*virtualintelmac*" 2>/dev/null
find ~/Library /Library /private/var/folders -iname "*#{bundle_id}*" 2>/dev/null
```

Careful: the virtual machines themselves may be stored in one of these folders.
`brew uninstall --zap` would delete them.

```bash
# update new sha256 sum when new version is out

# without version it rechecks the version from string
bash update-cask-sha.sh Casks/ultimate-lemmings.rb

# with version it creates new version and sha256 string
bash update-cask-sha.sh Casks/ultimate-lemmings.rb 2.2.2,build99
```

## Casks

* airport-konfigurator
* atomic-chat
* crystalrcm
* dmde
* dmde@beta
* fs-uae@alpha
* katalog
* m5uploader
* makemkv-preservation
* newshosting
* notational-velocity
* notproton
* ultimate-lemmings
* ultimate-lemmings@slim
* virtual-intel-mac
* xact-preservation
* xld-preservation

```bash
# show remote recipe 
brew cat --cask concr/tap/[CASK]

# strict check recipe
brew audit --cask --strict --online concr/tap/[CASK]

# check upstream for new version
brew livecheck --cask concr/tap/[CASK]
```

## Formula

* TODO: DMDE console
  * https://dmde.com/download/dmde-4-4-6-846-mac64-con.dmg
  * https://dmde.com/download/dmde-4-5-0-849-beta-mac64-con.dmg
