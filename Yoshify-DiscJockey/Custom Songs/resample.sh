
for file in *.mp3; do
    ffprobe -v error -select_streams a:0 -show_entries stream=sample_rate -of default=noprint_wrappers=1:nokey=1 "$file" | grep -q 48000 || ffmpeg -i "$file" -ar 48000 -c:a libmp3lame -q:a 2 "CCC_${file%.mp3}_resampled.mp3"
done

echo "CCC_*_resampled.mp3"

for file in CCC_*_resampled.mp3; do
    original_file="${file#"CCC_"}"
    original_file="${original_file%_resampled.mp3}.mp3"
    rm "$original_file"
done
