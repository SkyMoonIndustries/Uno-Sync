# 🚗 uno-sync

> A minimalist, terminal-based YouTube playlist downloader and audio normalizer. Originally built to keep the music flowing seamlessly in a '98 Fiat Uno.

## Overview
**uno-sync** is a standalone Bash script designed to perfectly format YouTube playlists for standard car stereos. It handles the heavy lifting of downloading, converting, tagging, and normalizing audio, ensuring a smooth, interruption-free listening experience on the road.

## Key Features
*   **Car-Stereo Friendly Naming:** Flattens playlists into a single directory with a strict `001 - Title.mp3` naming convention. Ensures sequential playback on older USB head units.
*   **Audio Normalization (loudnorm):** Applies `ffmpeg`'s loudnorm filter to equalize volume levels across all tracks. No more sudden volume spikes or drops while driving.
*   **Smart Syncing:** Creates a hidden `.uno-sync-archive.txt` in your target folder. Run the script again on the same playlist months later, and it will only download the newly added tracks.
*   **Rich Metadata:** Automatically embeds YouTube thumbnails as album art and writes ID3 tags for a clean display on supported screens.
*   **High Quality:** Forces standard 320kbps MP3 conversion for maximum compatibility and quality.

## Prerequisites
You need `ffmpeg` and a relatively recent version of `yt-dlp`. 

On Debian/Ubuntu-based systems:

```bash
# Install ffmpeg
sudo apt update && sudo apt install ffmpeg -y

# Install the latest yt-dlp directly from the source (Recommended)
sudo wget https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -O /usr/local/bin/yt-dlp
sudo chmod a+rx /usr/local/bin/yt-dlp
```

## Installation
Clone the repository and make the script executable. You can also move it to your bin directory to run it globally.

```bash
git clone https://github.com/yourusername/uno-sync.git
cd uno-sync
chmod +x uno-sync.sh

# Optional: Make it accessible globally
sudo mv uno-sync.sh /usr/local/bin/uno-sync
```

## Usage
Simply run the script in your terminal and follow the two interactive prompts.

```bash
uno-sync
```

**Workflow:**
1. Paste your YouTube Playlist URL.
2. Enter a folder name (e.g., `90s_Rock_Mix`).
3. Sit back. The script will create the folder, download the tracks in order, normalize the audio, and save them. Once done, just copy the folder to your USB drive and plug it into your car.

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.