#!/usr/bin/env bash

# make sure output directory exists
mkdir -p html

echo "Translating .let files to HTML..."
for file in src/*.let; do
  [ -e "$file" ] || continue # skip if no matches
  lua letdown/letdown.lua -t template.html "$file"
  filename=$(basename "$file" .let)
  mv src/"$filename.html" html/
done

echo "Moving attachment files..."
find src -maxdepth 1 -type f ! -name "*.let" -exec cp {} html \;

echo "Copying style.css..."
cp style.css html/

echo "Done."
