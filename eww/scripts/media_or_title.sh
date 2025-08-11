#!/usr/bin/env bash
# If music playing: "Artist - Title", else focused window title, else " "
if playerctl status >/dev/null 2>&1; then
  status=$(playerctl status 2>/dev/null)
  if [ "$status" = "Playing" ]; then
    artist=$(playerctl metadata artist 2>/dev/null)
    title=$(playerctl metadata title 2>/devnull)
    out="${artist:+$artist - }${title}"
    [ -n "$out" ] && {
      echo "$out"
      exit 0
    }
  fi
fi
title=$(hyprctl -j activewindow 2>/dev/null | jq -r '.title // empty')
[ -n "$title" ] && {
  echo "$title"
  exit 0
}
echo " "
