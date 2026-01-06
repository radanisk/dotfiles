#!/bin/sh
set -e

usage() {
  echo "Usage: link.sh <source> <target>" >&2
  exit 2
}

SOURCE="$1"
TARGET="$2"

if [ -z "$SOURCE" ] || [ -z "$TARGET" ]; then
  usage
fi

if [ ! -e "$SOURCE" ]; then
  echo "ERROR: source missing: $SOURCE" >&2
  exit 1
fi

if [ -L "$TARGET" ]; then
  link="$(readlink "$TARGET")"
  if [ -n "$link" ]; then
    case "$link" in
      /*) link_abs="$link" ;;
      *) link_abs="$(cd "$(dirname "$TARGET")" && pwd)/$link" ;;
    esac
    if [ "$link_abs" = "$SOURCE" ]; then
      echo "OK: $TARGET already linked"
      exit 0
    fi
  fi
fi

if [ -e "$TARGET" ] || [ -L "$TARGET" ]; then
  ts="$(date +"%Y%m%d%H%M%S")"
  backup="${TARGET}.bak.${ts}"
  echo "BACKUP: $TARGET -> $backup"
  if [ -n "$DRY_RUN" ]; then
    echo "DRY_RUN: mv \"$TARGET\" \"$backup\""
    echo "DRY_RUN: ln -s \"$SOURCE\" \"$TARGET\""
    exit 0
  fi
  mv "$TARGET" "$backup"
fi

if [ -n "$DRY_RUN" ]; then
  echo "DRY_RUN: ln -s \"$SOURCE\" \"$TARGET\""
  exit 0
fi

mkdir -p "$(dirname "$TARGET")"
ln -s "$SOURCE" "$TARGET"
echo "LINK: $TARGET -> $SOURCE"
