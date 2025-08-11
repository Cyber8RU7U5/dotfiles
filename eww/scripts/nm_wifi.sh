#!/usr/bin/env bash
# Modes:
#  - no args: print icon status
#  - toggle: toggle radio
mode="$1"
if [ "$mode" = "toggle" ]; then
  state=$(nmcli r wifi)
  if [ "$state" = "enabled" ]; then nmcli r wifi off; else nmcli r wifi on; fi
  exit 0
fi
# Status icon
if ! command -v nmcli >/dev/null; then
  echo "睊"
  exit 0
fi
if [ "$(nmcli r wifi)" = "disabled" ]; then
  echo "睊"
  exit 0
fi
ssid=$(nmcli -t -f active,ssid,signal dev wifi | awk -F: '$1=="yes"{print $2" "$3; exit}')
if [ -n "$ssid" ]; then echo ""; else echo "直"; fi
