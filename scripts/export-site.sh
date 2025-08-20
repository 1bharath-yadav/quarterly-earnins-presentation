#!/usr/bin/env bash
# Simple exporter: build reveal.js assets and copy site root to docs/
set -euo pipefail
ROOT_DIR=$(cd "$(dirname "$0")/.." && pwd)
cd "$ROOT_DIR"

# Run npm build (uses gulp build)
if command -v npm >/dev/null 2>&1; then
  echo "Running npm install (dev dependencies) and npm run build..."
  npm install
  npm run build
else
  echo "npm not found. Install Node.js (>=18) and npm, then rerun."
  exit 1
fi

# Create docs dir and copy files needed to serve the presentation
rm -rf docs
mkdir docs
cp -r dist plugin css js examples index.html README.md docs/

# Ensure index.html at root of docs is the presentation entry
if [ -f docs/index.html ]; then
  echo "Export complete: docs/ now contains the site. Zip or upload docs/ to your Pages host."
else
  echo "Export failed: docs/index.html missing"
  exit 2
fi
