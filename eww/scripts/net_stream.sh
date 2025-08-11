#!/usr/bin/env bash
# Usage: net_stream.sh up|down [values|max]
# Emits either:
#  - "values": 60-sample kbps series (space-separated) every second
#  - "max":    max kbps seen in the last 60s (floored to 10000) every second

dir="$1"
mode="${2:-values}"

iface=${NET_IFACE:-$(ip route get 1.1.1.1 2>/dev/null | awk '/dev/ {for (i=1;i<=NF;i++) if ($i=="dev") print $(i+1)}')}
[ -z "$iface" ] && iface=$(ip -o -4 addr show | awk '!/ lo / {print $2; exit}')

path_rx="/sys/class/net/$iface/statistics/rx_bytes"
path_tx="/sys/class/net/$iface/statistics/tx_bytes"
[ ! -e "$path_rx" ] && {
  echo "0"
  exit 0
}

prev_rx=$(cat "$path_rx")
prev_tx=$(cat "$path_tx")
buf=()

max_of_buf() {
  local m=0 v
  for v in "${buf[@]}"; do
    ((v > m)) && m=$v
  done
  # floor to 10 Mbps (10000 kbps)
  ((m < 10000)) && m=10000
  echo "$m"
}

while :; do
  sleep 1
  rx=$(cat "$path_rx")
  tx=$(cat "$path_tx")
  drx=$((rx - prev_rx))
  dtx=$((tx - prev_tx))
  prev_rx=$rx
  prev_tx=$tx

  # bytes/sec -> kilobits/sec
  up_kbps=$(((dtx * 8) / 1000))
  down_kbps=$(((drx * 8) / 1000))
  val=$([ "$dir" = "up" ] && echo "$up_kbps" || echo "$down_kbps")

  buf+=("$val")
  # keep last 60 samples
  if [ ${#buf[@]} -gt 60 ]; then
    buf=("${buf[@]: -60}")
  fi

  if [ "$mode" = "max" ]; then
    max_of_buf
  else
    printf "%s " "${buf[@]}"
    echo
  fi
done
