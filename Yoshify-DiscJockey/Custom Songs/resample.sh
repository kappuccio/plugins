
for file in *.mp3; do
    ffprobe -v error -select_streams a:0 -show_entries stream=sample_rate -of default=noprint_wrappers=1:nokey=1 "$file" | grep -q 48000 || ffmpeg -i "$file" -ar 48000 -c:a libmp3lame -q:a 2 "${file%.mp3}_resampled.mp3"
done

for file in *_resampled.mp3; do
    original_file="${file%_resampled.mp3}.mp3"
    rm "$original_file"
done
