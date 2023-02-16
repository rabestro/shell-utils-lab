#!/usr/bin/env bash

CODE_BASE="$HOME/Projects/jdk/src/java.base/share/classes/java/util/"

find "$CODE_BASE" -type f -iname "*.java" \
  -exec sed -f clean.sed {} \; \
  | gawk -f conditions.awk \
  > report.txt
