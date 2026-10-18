#!/bin/bash

# Renk kodları
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== uno-sync | Araç İçi Müzik Senkronizasyonu ===${NC}"
echo "Playlistleri ses eşitlemesi (loudnorm) ile 320kbps MP3 yapar,"
echo "sadece klasörde eksik olan yeni parçaları senkronize eder."
echo "--------------------------------------------------------"

# Gerekli bağımlılıkların kontrolü
for cmd in yt-dlp ffmpeg; do
    if ! command -v $cmd &> /dev/null; then
        echo -e "${RED}Hata: '$cmd' yüklü değil! Lütfen yükleyip tekrar deneyin.${NC}"
        exit 1
    fi
done

# Kullanıcıdan verileri alma
read -p "İndirilecek YouTube Playlist URL'si: " PLAYLIST_URL
if [ -z "$PLAYLIST_URL" ]; then
    echo -e "${RED}URL boş bırakılamaz! Çıkılıyor...${NC}"
    exit 1
fi

read -p "Şarkıların kaydedileceği klasör adı (Örn: Yol_Sarkilari): " FOLDER_NAME
if [ -z "$FOLDER_NAME" ]; then
    echo -e "${RED}Klasör adı boş bırakılamaz! Çıkılıyor...${NC}"
    exit 1
fi

# Klasörü oluştur
mkdir -p "$FOLDER_NAME"
echo -e "${GREEN}Hedef klasör hazırlandı: $FOLDER_NAME${NC}"
echo -e "${BLUE}uno-sync başlatılıyor... (Sadece yeni eklenenler indirilecek)${NC}"

# yt-dlp komutu - Arşiv ve 3 Hane düzeltmesi eklendi
yt-dlp \
    --ignore-errors \
    --extract-audio \
    --audio-format mp3 \
    --audio-quality 0 \
    --add-metadata \
    --embed-thumbnail \
    --download-archive "${FOLDER_NAME}/.uno-sync-archive.txt" \
    --postprocessor-args "ffmpeg:-af loudnorm -b:a 320k" \
    -o "${FOLDER_NAME}/%(playlist_index)03d - %(title)s.%(ext)s" \
    "${PLAYLIST_URL}"

echo "--------------------------------------------------------"
echo -e "${GREEN}uno-sync tamamlandı! Yeni şarkılar '$FOLDER_NAME' klasörüne işlendi.${NC}"