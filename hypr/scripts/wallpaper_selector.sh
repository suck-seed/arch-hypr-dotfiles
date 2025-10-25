#!/bin/bash

THEMEIS=$(readlink -f ~/.config/waybar/style.css | cut -d '-' -f2)

if [ $THEMEIS != "dark.css" ]; then
  SWITCHTO=""
else
  SWITCHTO="-dark"
fi

WALLPAPER_DIR="$HOME/.config/hypr/wallpapers/themes/images$SWITCHTO"
#
# === CONFIG ===
SYMLINK_PATH="$HOME/.config/hypr/wallpapers/wallpaper.jpg"

cd "$WALLPAPER_DIR" || exit 1

# === handle spaces name
IFS=$'\n'

# === ICON-PREVIEW SELECTION WITH ROFI, SORTED BY NEWEST ===
SELECTED_WALL=$(for a in $(ls -t *.jpg *.png *.gif *.jpeg 2>/dev/null); do echo -en "$a\0icon\x1f$a\n"; done | rofi -dmenu -p "")
[ -z "$SELECTED_WALL" ] && exit 1
SELECTED_PATH="$WALLPAPER_DIR/$SELECTED_WALL"

ln -sf $SELECTED_PATH $WALLPAPER_DIR/link

# === SET WALLPAPER ===
ln -sf $WALLPAPER_DIR/link $SYMLINK_PATH

swww img "$SYMLINK_PATH" --transition-type any --transition-duration 1.5
magick "$SYMLINK_PATH" -resize 2300x1294\> -quality 85 "$HOME/.config/rofi/wallpaper.jpg"
cp "$HOME/.config/rofi/wallpaper.jpg" "$HOME/.config/wlogout/wallpaper.jpg"
magick "$HOME/.config/wlogout/wallpaper.jpg" -blur 0x8 ~/.config/wlogout/wallpaper.jpg
