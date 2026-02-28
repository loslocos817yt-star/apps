#!/bin/bash

# Función para detener el reloj con Ctrl+C sin romper VerduraOS
trap "echo -e '\nReloj detenido.'; exit" SIGINT

echo "--- 🕒 Reloj de VerduraOS ---"
echo "Presiona Ctrl+C para volver al prompt."
echo "----------------------------"

# Bucle infinito que actualiza la hora en la misma línea
while true; do
    # \r regresa el cursor al inicio de la línea
    # -n evita que salte a una línea nueva
    echo -ne "  📅 $(date +'%d/%m/%Y')  |  ⏰ $(date +'%H:%M:%S')\r"
    sleep 1
done
