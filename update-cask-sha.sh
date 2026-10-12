#!/bin/bash
# Update a cask file to a new version: set `version`, download the url and
# write the new `sha256` into the file.
#
# Usage:
#   ./cask-bump.sh Casks/notproton.rb 1.2.0     # set version 1.2.0, update sha256
#   ./cask-bump.sh Casks/notproton.rb           # keep version, just refresh sha256
#   ./cask-bump.sh -n Casks/notproton.rb 1.2.0  # dry run: only print the url
#
# Reads from the file:
#   version "…"                     the version
#   name = "…"                      your own string variables
#   url "…"                         the download url
# and fills in #{version}, #{my_var}, #{version.csv.first}, #{version.csv.second},
# #{version.major}, .minor, .patch, .major_minor, .dots_to_hyphens,
# .dots_to_underscores, .no_dots, … (chains work, e.g.
# #{version.csv.first.dots_to_hyphens}).
#
# Not supported (the script stops with a message): per-arch `sha256 arm:/intel:`,
# `#{arch}`, `#{language}`, and `sha256 :no_check`.
set -eu

dry_run=false
if [ "${1:-}" = "-n" ]; then dry_run=true; shift; fi

file="${1:?Usage: $0 [-n] path/to/cask.rb [new-version]}"
new_version="${2:-}"
[ -f "$file" ] || { echo "No such file: $file" >&2; exit 1; }

die() { echo "Error: $*" >&2; exit 1; }

# --- read values from the cask file ------------------------------------------

# First `version "…"` line.
read_version() {
  sed -n 's/^[[:space:]]*version[[:space:]]*"\([^"]*\)".*/\1/p' "$file" | head -n 1
}

# A local variable: `name = "value"`
read_var() {
  sed -n "s/^[[:space:]]*$1[[:space:]]*=[[:space:]]*\"\\([^\"]*\\)\".*/\\1/p" "$file" | head -n 1
}

# --- version helpers (same names as Homebrew's) ------------------------------

apply_method() { # $1 = value, $2 = method name
  local v="$1"
  case "$2" in
    major)                 echo "$v" | cut -d. -f1 ;;
    minor)                 echo "$v" | cut -d. -f2 ;;
    patch)                 echo "$v" | cut -d. -f3 ;;
    major_minor)           echo "$v" | cut -d. -f1-2 ;;
    major_minor_patch)     echo "$v" | cut -d. -f1-3 ;;
    before_comma)          echo "${v%%,*}" ;;
    after_comma)           echo "${v#*,}" ;;
    no_dots)               echo "$v" | tr -d . ;;
    no_hyphens)            echo "$v" | tr -d - ;;
    no_underscores)        echo "$v" | tr -d _ ;;
    no_dividers)           echo "$v" | tr -d ._- ;;
    dots_to_hyphens)       echo "$v" | tr . - ;;
    dots_to_underscores)   echo "$v" | tr . _ ;;
    hyphens_to_dots)       echo "$v" | tr - . ;;
    hyphens_to_underscores) echo "$v" | tr - _ ;;
    underscores_to_dots)   echo "$v" | tr _ . ;;
    underscores_to_hyphens) echo "$v" | tr _ - ;;
    downcase)              echo "$v" | tr '[:upper:]' '[:lower:]' ;;
    upcase)                echo "$v" | tr '[:lower:]' '[:upper:]' ;;
    *) die "unsupported method '.$2' in url" ;;
  esac
}

# Evaluate one expression from inside #{…}
evaluate() {
  local expr="$1" head rest value part
  head="${expr%%.*}"
  if [ "$head" = "$expr" ]; then rest=""; else rest="${expr#*.}"; fi

  case "$head" in
    version) value="$version" ;;
    arch|language|os) die "#{$head} is not supported by this script" ;;
    *)
      value="$(read_var "$head")"
      [ -n "$value" ] || die "variable '$head' not found (needs a line like: $head = \"…\")"
      ;;
  esac

  while [ -n "$rest" ]; do
    part="${rest%%.*}"
    if [ "$part" = "$rest" ]; then rest=""; else rest="${rest#*.}"; fi

    if [ "$part" = "csv" ]; then
      part="${rest%%.*}"
      if [ "$part" = "$rest" ]; then rest=""; else rest="${rest#*.}"; fi
      case "$part" in
        first)  value="$(echo "$value" | cut -d, -f1)" ;;
        second) value="$(echo "$value" | cut -d, -f2)" ;;
        third)  value="$(echo "$value" | cut -d, -f3)" ;;
        fourth) value="$(echo "$value" | cut -d, -f4)" ;;
        *) die "unsupported 'csv.$part' in url" ;;
      esac
    else
      value="$(apply_method "$value" "$part")"
    fi
  done
  printf '%s' "$value"
}

# Replace every #{…} in a string
interpolate() {
  local s="$1" out="" expr
  while :; do
    case "$s" in
      *'#{'*'}'*)
        out="$out${s%%\#\{*}"
        s="${s#*\#\{}"
        expr="${s%%\}*}"
        s="${s#*\}}"
        out="$out$(evaluate "$expr")"
        ;;
      *) out="$out$s"; break ;;
    esac
  done
  printf '%s' "$out"
}

# --- checks -------------------------------------------------------------------

grep -Eq '^[[:space:]]*sha256[[:space:]]+:no_check' "$file" \
  && die "cask uses 'sha256 :no_check', nothing to update"
grep -Eq '^[[:space:]]*sha256[[:space:]]+(arm|intel):' "$file" \
  && die "per-architecture sha256 (arm:/intel:) is not supported"
grep -Eq '^[[:space:]]*sha256[[:space:]]+"[0-9a-fA-F]*"' "$file" \
  || die "no line like: sha256 \"…\" found"

old_version="$(read_version)"
[ -n "$old_version" ] || die "no line like: version \"…\" found"

# --- go -----------------------------------------------------------------------

version="${new_version:-$old_version}"

raw_url="$(sed -n 's/^[[:space:]]*url[[:space:]]*"\([^"]*\)".*/\1/p' "$file" | head -n 1)"
[ -n "$raw_url" ] || die "no line like: url \"…\" found"
url="$(interpolate "$raw_url")"

echo "Cask:    $file"
echo "Version: $old_version${new_version:+ -> $new_version}"
echo "URL:     $url"
$dry_run && exit 0

tmp="$(mktemp)"
trap 'rm -f "$tmp"' EXIT
curl -fL --progress-bar -o "$tmp" "$url" || die "download failed"
sha="$(shasum -a 256 "$tmp" | cut -d' ' -f1)"
echo "SHA256:  $sha"

# Only touch the file once the download worked.
# Replaces the value of the first line matching $1 with $2.
set_first() { # $1 = stanza (version|sha256), $2 = new value
  local tmpf
  tmpf="$(mktemp)"
  awk -v key="$1" -v val="$2" '
    !done && $0 ~ "^[[:space:]]*" key "[[:space:]]+\"[^\"]*\"" {
      sub(/"[^"]*"/, "\"" val "\""); done = 1
    }
    { print }' "$file" > "$tmpf" && cat "$tmpf" > "$file"
  rm -f "$tmpf"
}

[ -n "$new_version" ] && set_first version "$new_version"
set_first sha256 "$sha"

echo "Updated $file"
