#!/bin/bash

# Ses dosyasının yolu (Aynı klasörde olduğundan emin ol)
SES_DOSYASI="$(dirname "$0")/hee_hee.mp3"

BUGUN=$(date +%Y-%m-%d)
BASLANGIC=$(date -d "$BUGUN 13:40:00" +%s)
BITIS=$(date -d "$BUGUN 14:20:00" +%s)

# Pencere başlayana kadar bekle
SIMDI=$(date +%s)
if [ $SIMDI -lt $BASLANGIC ]; then
    BEKLE=$(( BASLANGIC - SIMDI ))
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
