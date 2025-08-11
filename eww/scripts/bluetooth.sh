#!/usr/bin/env bash
# Modes: toggle | (default) print icon
mode="$1"
if [ "$mode" = "toggle" ]; then
  if rfkill list bluetooth | grep -q 'Soft blocked: yes'; then
    rfkill unblock bluetooth
  else
    rfkill block bluetooth
  fi
  exit 0
fi
if rfkill list bluetooth 2>/dev/null | grep -q 'Soft blocked: yes'; then
  echo "" # off
else
  # Show connected if any
  if bluetoothctl info | grep -q 'Connected: yes'; then echo ""; else echo ""; fi
fi
