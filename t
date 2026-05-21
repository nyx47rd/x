#!/bin/bash

SES_DOSYASI="/tmp/hee_hee.mp3"
if [ ! -f "$SES_DOSYASI" ]; then
    curl -sL https://raw.githubusercontent.com/nyx47rd/x/main/hee_hee.mp3 -o "$SES_DOSYASI"
fi

echo "[$(date +%H:%M:%S)] Başladı. Durdurmak için Ctrl+C"

SAYAC=1
while true; do
    echo "[$(date +%H:%M:%S)] [$SAYAC] -> HEE-HEE!"
    paplay "$SES_DOSYASI" > /dev/null 2>&1
    BEKLE=$(( RANDOM % 3 + 1 ))
    echo "[$(date +%H:%M:%S)] $BEKLE sn bekleniyor..."
    sleep $BEKLE
    ((SAYAC++))
done
