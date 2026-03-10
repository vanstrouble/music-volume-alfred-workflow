#!/bin/zsh

query="$1"

item() {
    local title="$1"
    local subtitle="$2"
    local arg="$3"
    local valid="${4:-true}"

    echo "{\"title\":\"$title\",\"subtitle\":\"$subtitle\",\"arg\":\"$arg\",\"valid\":$valid}"
}

add_item() {
    items+=("$(item "$@")")
}

items=()

if [[ -z "$query" ]]; then
    add_item "Type a command" "Use: up, down or 0-100" "" "false"
elif [[ "$query" == "up" || "$query" == "u" ]]; then
    add_item "Volume Up" "Increase volume by 10%" "u"
elif [[ "$query" == "down" || "$query" == "d" ]]; then
    add_item "Volume Down" "Decrease volume by 10%" "d"
elif [[ "$query" =~ ^[0-9]+$ ]]; then
    local level=$((10#$query))

    if (( level >= 0 && level <= 100 )); then
        add_item "Set Volume" "Change volume to ${level}%" "${level}"
    else
        add_item "Value out of range" "Volume must be between 0 and 100 (received: ${level})" "" "false"
    fi
else
    add_item "Invalid input" "Use: up, down, or 0-100" "" "false"
fi

echo "{\"items\":[${(j:,:)items}]}"
