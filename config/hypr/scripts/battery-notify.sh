#!/usr/bin/env bash

# Reads directly from /sys/class/power_supply
# Works anywhere, no upower or dbus needed.

BAT_PATH="/sys/class/power_supply/BAT0"
STATE=""
LEVEL=""

while true; do
    [[ ! -d "$BAT_PATH" ]] && sleep 60 && continue

    CAPACITY=$(<"$BAT_PATH/capacity")
    STATUS=$(<"$BAT_PATH/status")

    if [[ "$STATUS" == "Discharging" && "$CAPACITY" -le 15 && "$LEVEL" != "low" ]]; then
        notify-send -u critical "⚠️ Battery Low" "Level: ${CAPACITY}%"
        LEVEL="low"

    elif [[ "$STATUS" == "Discharging" && "$CAPACITY" -le 5 && "$LEVEL" != "critical" ]]; then
        notify-send -u critical "💀 Battery Critical" "Plug in your charger before it dies."
        LEVEL="critical"

    elif [[ "$STATUS" == "Discharging" && "$CAPACITY" -le 3 ]]; then
        notify-send -u critical "💤 Hibernating" "Battery almost dead."
        systemctl hibernate

    elif [[ "$STATUS" =~ ^Charging|Full$ && "$CAPACITY" -ge 95 && "$LEVEL" != "full" ]]; then
        notify-send -u normal "🔋 Battery Full" "You can unplug the charger now."
        LEVEL="full"
    fi

    sleep 60
done

