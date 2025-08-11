#!/usr/bin/env bash
# Outputs a new 60-sample space-separated CPU% series every second
buf=()
read -r _ a b c idle _ </proc/stat
prev_total=$((a + b + c + idle))
prev_idle=$idle
while :; do
  sleep 1
  read -r _ a b c idle _ </proc/stat
  total=$((a + b + c + idle))
  idle_d=$((idle - prev_idle))
  total_d=$((total - prev_total))
  pct=$((100 * (total_d - idle_d) / (total_d == 0 ? 1 : total_d)))
  prev_total=$total
  prev_idle=$idle
  buf=("${buf[@]}" "$pct")
  [ ${#buf[@]} -gt 60 ] && buf=("${buf[@]: -60}")
  printf "%s " "${buf[@]}"
  echo
done
