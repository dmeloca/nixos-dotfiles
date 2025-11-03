#!/usr/bin/env bash

# Opciones del menú
OPTIONS="Lock
Shutdown
Reboot
Suspend
Logout"

# Mostrar el menú y capturar la elección
CHOICE=$(echo -e "$OPTIONS" | wofi --dmenu --prompt "Power Menu:")

# Ejecutar según elección
case "$CHOICE" in
    Lock)
        hyprlock
        ;;
    Shutdown)
        systemctl poweroff
        ;;
    Reboot)
        systemctl reboot
        ;;
    Suspend)
        systemctl suspend
        ;;
    Logout)
        # Para Hyprland, matas la sesión actual
        hyprctl dispatch exit
        ;;
    *)
        exit 0
        ;;
esac

