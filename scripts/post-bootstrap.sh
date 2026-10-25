#! /bin/bash

# Delete lines matching the sed pattern $2 from file $1. Avoids `sed -i`, which
# takes different arguments on BSD (macOS) and GNU sed.
strip() {
  if [ -f "$1" ]; then
    TMP_FILE=$(mktemp)
    sed "/$2/d" "$1" > "$TMP_FILE"
    cat "$TMP_FILE" > "$1"
    rm -f "$TMP_FILE"
  fi
}

for target in "~/.bashrc" "~/.bash_profile"; do
  strip_file $target "# dotfiles"
  strip_file $target ".cargo\\/env"
done
