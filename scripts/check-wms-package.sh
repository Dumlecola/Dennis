#!/usr/bin/env bash
set -euo pipefail
ZIP="${1:-dennis_wms_2.2.14_multishop_workflow_foundation.zip}"
if [[ ! -f "$ZIP" ]]; then echo "Missing package: $ZIP" >&2; exit 1; fi
WORK="$(mktemp -d)"
trap 'rm -rf "$WORK"' EXIT
unzip -q "$ZIP" -d "$WORK"
ROOT="$WORK/pb-wms"
[[ -f "$ROOT/pb-wms.php" ]] || { echo "Missing plugin bootstrap" >&2; exit 1; }
for file in multi-shop.php order-ui.php remote-workflow.php; do
  [[ -f "$ROOT/$file" ]] || { echo "Missing multi-shop component: $file" >&2; exit 1; }
done
find "$ROOT" -type f -name '*.php' -print0 | while IFS= read -r -d '' file; do php -l "$file" >/dev/null || exit 1; done
echo "OK: package structure and PHP syntax"
