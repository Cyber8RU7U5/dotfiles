#!/usr/bin/env bash
# Prints battery percentage (int). Works with upower or sysfs fallback.
if command -v upower >/dev/null; then
  dev=$(upower -e | grep -m1 'BAT' || true)
  [ -n "$dev" ] && upower -i "$dev" | awk -F: '/percentage/ {gsub("%","",$2); print int($2)}' && exit 0
fi
for b in /sys/class/power_supply/BAT*/capacity; do
  [ -f "$b" ] && cat "$b" && exit 0
done
echo 100
