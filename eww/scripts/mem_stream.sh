#!/usr/bin/env bash
# 60-sample memory usage percent
buf=()
while :; do
  avail=$(grep -E '^MemAvailable:' /proc/meminfo | awk '{print $2}')
  total=$(grep -E '^MemTotal:' /proc/meminfo | awk '{print $2}')
  used_pct=$(((100 * (total - avail)) / total))
  buf+=("$used_pct")
  [ ${#buf[@]} -gt 60 ] && buf=("${buf[@]: -60}")
  printf "%s " "${buf[@]}"
  echo
  sleep 1
done
