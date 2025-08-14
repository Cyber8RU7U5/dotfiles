#!/usr/bin/bash

PRODUCT=$(cat /sys/class/dmi/id/product_name)

case $PRODUCT in
*VMware*)
  foot
  ;;
*)
  kitty
  ;;
esac
