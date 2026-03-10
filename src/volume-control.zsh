#!/bin/zsh

# Optimized Music Volume Control Script
# Maintains compatibility with original music.zsh while minimizing osascript calls

# Fast app detection - Music for macOS 10.15+, iTunes for older versions
readonly APP_NAME=$([[ $(sw_vers -productVersion | cut -d. -f1) -ge 11 || ($(sw_vers -productVersion | cut -d. -f1) -eq 10 && $(sw_vers -productVersion | cut -d. -f2) -ge 15) ]] && echo "Music" || echo "iTunes")

# Early return for missing arguments
[[ $# -eq 0 ]] && { echo "Usage: $0 vol [up|down|<0-100>]"; exit 1; }

readonly opt="$1"
shift

# Early return for non-vol commands (future extensibility)
[[ "$opt" != "vol" ]] && { echo "Unknown command: $opt"; exit 1; }

# Volume control logic with optimized osascript calls
case "${1:-}" in
    # Show current volume when no argument provided - single osascript call
    ""|"show")
        volume=$(osascript -e "tell application \"$APP_NAME\" to get sound volume")
        echo "Current volume is ${volume}."
        ;;

    # Volume up - atomic operation in single osascript call
    "up"|"u")
        result=$(osascript -e "
        tell application \"$APP_NAME\"
            set currentVol to sound volume
            set newVol to (currentVol + 10)
            if newVol > 100 then set newVol to 100
            set sound volume to newVol
            return newVol
        end tell")
        echo "Volume set to ${result}."
        ;;

    # Volume down - atomic operation in single osascript call
    "down"|"d")
        result=$(osascript -e "
        tell application \"$APP_NAME\"
            set currentVol to sound volume
            set newVol to (currentVol - 10)
            if newVol < 0 then set newVol to 0
            set sound volume to newVol
            return newVol
        end tell")
        echo "Volume set to ${result}."
        ;;

    # Specific volume level - validate and set in single call
    [0-9]*)
        # Early return for invalid range
        [[ $1 -lt 0 || $1 -gt 100 ]] && {
            echo "'$1' is not valid. Expected <0-100>, up or down.";
            exit 1;
        }

        osascript -e "tell application \"$APP_NAME\" to set sound volume to $1" >/dev/null
        echo "Volume set to $1."
        ;;

    # Invalid option - early return with error
    *)
        echo "'$1' is not valid. Expected <0-100>, up or down."
        exit 1
        ;;
esac
