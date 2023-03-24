# WebM -> gif using ffmpeg
# https://askubuntu.com/a/1350795
function webm2gif
    ffmpeg -y -i $1 -vf palettegen _tmp_palette.png
    ffmpeg -y -i $1 -i _tmp_palette.png -filter_complex paletteuse -r 10 $argv[1].webm.gif
    rm _tmp_palette.png
end
