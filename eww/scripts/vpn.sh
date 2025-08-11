#!/usr/bin/env bash
# Modes: toggle | menu | (default icon)
mode="$1"
default_vpn="${VPN_NAME:-vpn}" # export VPN_NAME to override

if [ "$mode" = "toggle" ]; then
  if nmcli c show --active | grep -qi 'vpn'; then
    nmcli c down type vpn
  else
    nmcli c up "$default_vpn" >/dev/null 2>&1 || notify-send "VPN" "Failed to connect '$default_vpn'"
  fi
  exit 0
fi

if [ "$mode" = "menu" ]; then
  list=$(nmcli -t -f name,type c show | awk -F: '$2=="vpn"{print $1}')
  sel=$(printf "%s\n" "$list" | wofi --dmenu -p "VPN")
  [ -n "$sel" ] && nmcli c up "$sel"
  exit 0
fi

# icon
if nmcli c show --active | grep -qi 'vpn'; then echo ""; else echo ""; fi
