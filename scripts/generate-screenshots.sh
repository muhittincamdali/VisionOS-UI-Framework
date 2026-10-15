#!/usr/bin/env bash
# Renders the README's layout diagrams from Tests/VisionUITests/Screenshots.swift on macOS.
#
# Every diagram is drawn from the placements the layouts return: a top view and a front view,
# with an arrow for the direction each item faces.
#
# Usage: scripts/generate-screenshots.sh
# Output: docs/images/layouts-light.png and docs/images/layouts-dark.png
set -euo pipefail

repo_root="$(cd "$(dirname "$0")/.." && pwd)"
mkdir -p "$repo_root/docs/images"
cd "$repo_root"
SCREENSHOT_DIR="$repo_root/docs/images" swift test --filter Screenshots
ls -1 "$repo_root"/docs/images/layouts-*.png
