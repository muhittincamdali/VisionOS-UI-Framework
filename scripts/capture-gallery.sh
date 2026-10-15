#!/usr/bin/env bash
# Captures the README screenshots of the SpatialGallery example app on a visionOS simulator.
#
# For each screenshot the script installs the app afresh (so no window from an earlier run is
# restored), opens a page with launch arguments, waits for it to settle and saves a simulator
# screenshot, cropped to the window or kept whole for the immersive space.
#
# Usage: scripts/capture-gallery.sh [simulator name or UDID]
# Without an argument it uses the "Apple Vision Pro" simulator. The crops are measured on its
# 3840 x 2160 screenshots with the window where visionOS first places it.
# Output: docs/images/visionos-*.png
set -euo pipefail

repo_root="$(cd "$(dirname "$0")/.." && pwd)"
device="${1:-Apple Vision Pro}"
bundle_id="io.github.muhittincamdali.SpatialGallery"
output_dir="$repo_root/docs/images"
build_dir="$(mktemp -d)"
trap 'rm -rf "$build_dir"' EXIT
mkdir -p "$output_dir"

destination="platform=visionOS Simulator,name=$device"
if [[ "$device" =~ ^[0-9A-F-]{36}$ ]]; then
  destination="platform=visionOS Simulator,id=$device"
fi
echo "Building SpatialGallery for '$device'"
xcodebuild build \
  -project "$repo_root/Examples/SpatialGallery/SpatialGallery.xcodeproj" \
  -scheme SpatialGallery \
  -destination "$destination" \
  -derivedDataPath "$build_dir" \
  -quiet
app="$(find "$build_dir/Build/Products" -maxdepth 2 -name 'SpatialGallery.app' -path '*xrsimulator*' | head -1)"

xcrun simctl boot "$device" 2>/dev/null || true
xcrun simctl bootstatus "$device" -b >/dev/null

# capture <file name> <crop: "height width top left" or "full"> <launch arguments...>
capture() {
  local name="$1" crop="$2"
  shift 2
  xcrun simctl uninstall "$device" "$bundle_id" 2>/dev/null || true
  xcrun simctl install "$device" "$app"
  xcrun simctl launch "$device" "$bundle_id" "$@" >/dev/null
  sleep 14 # the first launch after an install is slow, and windows fade in
  local file="$output_dir/$name.png"
  xcrun simctl io "$device" screenshot --type=png "$file" >/dev/null 2>&1
  if [[ "$crop" != "full" ]]; then
    read -r height width top left <<<"$crop"
    sips --cropToHeightWidth "$height" "$width" --cropOffset "$top" "$left" "$file" >/dev/null
  fi
  sips --resampleWidth 1200 "$file" >/dev/null
  echo "$file"
}

# The window, with some of the room around it, in 16:9.
window="1350 2400 480 720"
capture visionos-quick-start "$window" -page "Quick start"
capture visionos-carousel "$window" -page Carousel
capture visionos-ornament "$window" -page Components
capture visionos-immersive full -page "Immersive space" -open-immersive

xcrun simctl uninstall "$device" "$bundle_id" 2>/dev/null || true
