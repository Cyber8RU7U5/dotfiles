#!/usr/bin/env bash
# Prints active workspace id (int)
hyprctl -j activeworkspace 2>/dev/null | jq -r '.id // 1'
