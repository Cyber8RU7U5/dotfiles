#!/usr/bin/env bash
# Outputs a yuck list like: [1 2 3 4 5 9]
# Includes all current Hyprland workspaces + ensures a floor of MIN_WS (default 5).

MIN_WS="${MIN_WS:-5}"

# collect current workspace ids (fallback to empty)
mapfile -t ids < <(hyprctl -j workspaces 2>/dev/null | jq -r '.[].id' | sort -n | uniq)

# ensure at least 1..MIN_WS exist
for n in $(seq 1 "$MIN_WS"); do
  ids+=("$n")
done

# unique + sort
ids=($(printf "%s\n" "${ids[@]}" | awk '!seen[$0]++' | sort -n))

# print as a yuck list
printf "["
first=1
for n in "${ids[@]}"; do
  if [ $first -eq 1 ]; then first=0; else printf " "; fi
  printf "%s" "$n"
done
printf "]\n"
