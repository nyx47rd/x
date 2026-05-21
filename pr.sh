#!/bin/bash

SES_DOSYASI="/tmp/hee_hee.mp3"
if [ ! -f "$SES_DOSYASI" ]; then
    curl -sL https://raw.githubusercontent.com/nyx47rd/x/main/hee_hee.mp3 -o "$SES_DOSYASI"
fi

# Bir sonraki 13:40'ı hesapla (bugün geçtiyse yarını al)
BUGUN=$(date +%Y-%m-%d)
BASLANGIC=$(date -d "$BUGUN 13:40:00" +%s)
BITIS=$(date -d "$BUGUN 14:20:00" +%s)
SIMDI=$(date +%s)

# Bugünün 13:40'ı geçtiyse yarına ayarla
if [ $SIMDI -ge $BASLANGIC ]; then
    YARIN=$(date -d "tomorrow" +%Y-%m-%d)
    BASLANGIC=$(date -d "$YARIN 13:40:00" +%s)
    BITIS=$(date -d "$YARIN 14:20:00" +%s)
fi

# Pencere başlayana kadar bekle
BEKLE=$(( BASLANGIC - SIMDI ))
if [ $BEKLE -gt 0 ]; then
    echo "[$(date +%H:%M:%S)] Pencere başlayana kadar $BEKLE sn bekleniyor (13:40)..."
    sleep $BEKLE
fi

echo "[$(date +%H:%M:%S)] === OPERASYON BAŞLADI (pencere: 13:40-14:20) ==="

SAYAC=1
while [ $(date +%s) -lt $BITIS ]; do
    echo "[$(date +%H:%M:%S)] [$SAYAC] -> HEE-HEE!"
    paplay "$SES_DOSYASI" > /dev/null 2>&1

    # Bir sonraki çalma için 3-10 dakika rastgele bekle
    BEKLE=$(( RANDOM % 421 + 180 ))

    SONRAKI=$(( $(date +%s) + BEKLE ))
    if [ $SONRAKI -ge $BITIS ]; then
        break
    fi

    echo "[$(date +%H:%M:%S)] Sonraki: $(date -d @$SONRAKI +%H:%M:%S) ($BEKLE sn sonra)..."
    sleep $BEKLE
    ((SAYAC++))
done

echo "[$(date +%H:%M:%S)] === OPERASYON TAMAMLANDI ==="
