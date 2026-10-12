#!/bin/sh
# Prints the supported (non end-of-life) PostgreSQL major versions, one per line,
# sorted ascending. Source: https://endoflife.date/api/postgresql.json
set -eu

API_URL="${API_URL:-https://endoflife.date/api/postgresql.json}"
TODAY="$(date -u +%Y-%m-%d)"

curl -fsSL --retry 3 "$API_URL" \
  | jq -r --arg today "$TODAY" \
      '.[] | select(.eol == false or (.eol | type == "string" and . > $today)) | .cycle' \
  | sort -n
