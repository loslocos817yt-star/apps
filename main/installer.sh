#!/bin/bash

# ==============================================================================
# 🥦 VerduraOS - Instalador Pro (PattitexTEC Edition)
# ==============================================================================

# --- COLORES ---
C_V="\e[1;32m"; C_A="\e[1;33m"; C_C="\e[1;36m"; C_R="\e[1;31m"; C_0="\e[0m"

clear
echo -e "${C_V}Iniciando despliegue de VerduraOS...${C_0}"
echo -e "${C_C}================================================================${C_0}"

# --- PASO 1: REQUISITOS ---
echo -e "${C_A}📋 REQUISITOS DEL SISTEMA:${C_0}"
echo -e "1. Tener instalado 'jq' para el motor de comandos."
echo -e "2. Conexión a internet estable."
echo -e "3. Espacio en disco para el huerto de apps."
echo -e "4. Procesador compatible con Bash/Sh.\n"

# --- PASO 2: DESCARGA Y DESCOMPRESIÓN ---
echo -e "${C_C}[1/2] Descargando paquete maestro (Verdura.zip)...${C_0}"
URL="https://github.com/loslocos817yt-star/apps/raw/refs/heads/main/main/Verdura.zip"
wget -q "$URL" -O Verdura.zip

if [ $? -eq 0 ]; then
    echo -e "${C_V}✅ Descarga completada.${C_0}"
else
    echo -e "${C_R}❌ Error en la descarga. Verifica tu conexión.${C_0}"; exit 1
fi

echo -e "${C_C}[2/2] Extrayendo archivos...${C_0}"
if command -v unzip &> /dev/null; then
    unzip -o Verdura.zip > /dev/null
    echo -e "${C_V}✅ Extracción exitosa.${C_0}"
else
    echo -e "${C_R}❌ Error: 'unzip' no está instalado. Instálalo para continuar.${C_0}"; exit 1
fi

echo -e "\n${C_C}----------------------------------------------------------------${C_0}"
echo -e "${C_A}📖 MANUAL DE COMANDOS (PAGINADO):${C_0}"

# --- PASO 3: COMANDOS PAGINADOS (20 RENGLONES) ---
COMANDOS=(
    "1. help - Muestra la lista de comandos disponibles."
    "2. usar [json] - Cambia la tabla de comandos activa."
    "3. instalar.tabla - Descarga nuevas tablas desde el repo."
    "4. ver - Lista las apps plantadas en /apps."
    "5. instalar - Descarga todas las semillas del repositorio."
    "6. instalar.app - Instala una aplicación específica."
    "7. ejecutar [app] - Inicia una aplicación instalada."
    "8. borrar - Limpia la pantalla y refresca el logo."
    "9. limpiar - Elimina todas las apps del huerto."
    "10. link - Muestra la URL del repositorio configurado."
    "11. sys.stats - Muestra estadísticas de salud del Kernel."
    "12. sys.tech - Muestra las especificaciones técnicas."
    "13. sys.diag - Inicia un diagnóstico de hardware simulado."
    "14. sys.logs - Muestra el historial de eventos del sistema."
    "15. salir - Cierra el sistema VerduraOS (Emoji 🔥)."
    "16. update - Sincroniza el Kernel con la nube."
    "17. backup - Crea un respaldo de tu configuración."
    "18. restore - Restaura el sistema desde un respaldo."
    "19. network - Verifica la conexión con PattitexTEC."
    "20. info - Créditos y versión del desarrollador."
)

for i in "${!COMANDOS[@]}"; do
    num=$((i+1))
    echo -e "${C_V}[$num/20]${C_0} ${COMANDOS[$i]}"
    
    # Cada 5 renglones, pausar (excepto en el último)
    if [ $((num % 5)) -eq 0 ] && [ $num -lt 20 ]; then
        echo -e "\n${C_A}Presiona la tecla Enter para continuar...${C_0}"
        read -s
    fi
done

# --- CIERRE ---
echo -e "\n${C_C}----------------------------------------------------------------${C_0}"
echo -e "${C_A}VerduraOS se ha instalado, disfruta el servicio de PattitexTEC${C_0}"
echo -e "Escribe: ${C_V}cd Verdura && ./main.sh${C_0} para iniciar."

# Limpieza del instalador si lo deseas (opcional)
# rm Verdura.zip
