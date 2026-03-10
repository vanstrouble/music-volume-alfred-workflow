#!/bin/zsh

# Ultra-optimized Music Volume Control Script
# No input validation needed - handled by feedback.zsh

APP_NAME=Music

autoload is-at-least
if ! is-at-least 10.15 $(sw_vers -productVersion); then
    APP_NAME=iTunes
fi

set_volume() {
    local volume="$1"
    osascript -e "tell app \"$APP_NAME\" to set sound volume to $volume" >/dev/null
    echo "Current volume is ${volume}."
}

get_volume() {
    osascript -e "tell app \"$APP_NAME\" to get sound volume"
}

set_mute() {
    osascript -e "tell app \"$APP_NAME\" to set mute to true" >/dev/null
    echo "Muted."
}

set_unmute() {
    osascript -e "tell app \"$APP_NAME\" to set mute to false" >/dev/null
    echo "Unmuted."
}

# Direct argument parsing (from feedback.zsh args)
case "$1" in
    "u")
        volume=$(get_volume)
        volume=$((volume + 10))
        ((volume > 100)) && volume=100
        set_volume "$volume"
        ;;
    "d")
        volume=$(get_volume)
        volume=$((volume - 10))
        ((volume < 0)) && volume=0
        set_volume "$volume"
        ;;
    "m")
        set_mute
        ;;
    "um")
        set_unmute
        ;;
    [0-9]*)
        volume="$1"
        ((volume > 100)) && volume=100
        set_volume "$volume"
        ;;
    *)
        volume=$(get_volume)
        echo "Current volume is ${volume}."
        ;;
esac
