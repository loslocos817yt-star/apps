#!/bin/bash

# ==============================================================================
# 🥦 VerduraOS Kernel v8.0 - "THE GIGA-MONOLITH" (Dynamic Edition)
# ==============================================================================

# --- CAPA 0: DEFINICIÓN DE ENTORNOS Y VARIABLES MAESTRAS ---
export ROOT_DIR="$(pwd)"
export APPS_DIR="$ROOT_DIR/apps"
export USER_DIR="$ROOT_DIR/user"
export USER_KEY="$USER_DIR/user.key"
export CONF_DIR="$ROOT_DIR/config"
export CONF_FILE="$CONF_DIR/active.conf"
export LOG_FILE="$USER_DIR/system.log"
export BACKUP_DIR="$ROOT_DIR/backup"
export REPO_CACHE="$ROOT_DIR/.repo_cache"
export START_TIME=$(date +%s)

# --- CAPA 1: SISTEMA DE COLORES E INTERFAZ ---
C_V="\e[1;32m"; C_A="\e[1;33m"; C_C="\e[1;36m"; C_R="\e[1;31m"
C_M="\e[1;35m"; C_B="\e[1;37m"; C_G="\e[0;90m"; C_0="\e[0m"

# --- CAPA 2: MOTOR DE AUDITORÍA Y REGISTRO (LOGGING) ---
log_kernel() {
    local stamp=$(date '+%Y-%m-%d %H:%M:%S')
    local type="$1"
    local msg="$2"
    printf "[%s] [%-10s] %s\n" "$stamp" "$type" "$msg" >> "$LOG_FILE"
}

# --- CAPA 3: MANUAL TÉCNICO DE ARQUITECTURA ---
show_tech_specs() {
    echo -e "${C_B}================================================================${C_0}"
    echo -e "${C_V}         GIGA-MONOLITH | ESPECIFICACIONES DE NÚCLEO${C_0}"
    echo -e "${C_B}================================================================${C_0}"
    echo -e "${C_C}1. CONTROL DE VERSIONES DINÁMICO:${C_0}"
    echo "   El Kernel hereda su versión ($SYS_VERSION) directamente"
    echo "   del archivo JSON activo, permitiendo distribuciones custom."
    echo ""
    echo -e "${C_C}2. COMANDOS INMORTALES:${C_0}"
    echo "   'usar' e 'instalar.tabla' están embebidos en el Kernel."
    echo "   Nunca perderás el control, incluso si el JSON se corrompe."
    echo -e "${C_B}================================================================${C_0}"
}

# --- CAPA 4: FIREWALL PROACTIVO ---
SAFE_MODE=true
DANGER_DATABASE=(
    "rm -rf /" "sudo " "dd " "mkfs" ":(){:|:&};:" "shutdown" "reboot" 
    "nc -e" "bash -i" "curl * | bash" "wget * | bash" "chmod 777" ">: " 
    "kill -9 1" "rm -rf *" "mv / /" "alias ls=" "fork" "> /etc" "passwd"
    "iptables" "ufw" "chown" "chroot" "/dev/null" "nohup" "disown"
)

is_action_secure() {
    [ "$SAFE_MODE" != "true" ] && return 0
    for pattern in "${DANGER_DATABASE[@]}"; do
        if echo "$1" | grep -F -q "$pattern"; then
            echo -e "${C_R}🚨 FIREWALL: Acción rechazada por seguridad: $pattern${C_0}"
            log_kernel "SECURITY" "Bloqueo de patrón: $pattern"
            return 1
        fi
    done
    return 0
}

# --- CAPA 5: AUTENTICACIÓN Y CIFRADO ---
kernel_authenticate() {
    if [ ! -f "$USER_KEY" ]; then
        echo -e "${C_V}🌱 PRIMER ARRANQUE DETECTADO. INICIALIZANDO CIFRADO...${C_0}"
        read -p "Nombre del Agricultor: " u_reg
        while true; do
            read -s -p "Establecer Llave: " p_reg; echo ""
            read -s -p "Confirmar Llave: " p_conf; echo ""
            [ "$p_reg" == "$p_conf" ] && break
            echo -e "${C_R}❌ Error: Las llaves no coinciden.${C_0}"
        done
        local salt="$u_reg"
        local hash=$(printf "%s%s" "$p_reg" "$salt" | sha256sum | awk '{print $1}')
        echo "${u_reg}:${hash}" > "$USER_KEY"
        chmod 600 "$USER_KEY"
        CURRENT_USER="$u_reg"
    else
        local data=$(cat "$USER_KEY")
        local u_sav="${data%%:*}"; local h_sav="${data#*:}"
        echo -e "${C_V}🔒 VERDURAOS LOCK | SISTEMA BLINDADO${C_0}"
        read -p "Agricultor: " u_in; read -s -p "Contraseña: " p_in; echo ""
        local h_in=$(printf "%s%s" "$p_in" "$u_in" | sha256sum | awk '{print $1}')
        if [[ "$u_in" == "$u_sav" && "$h_in" == "$h_sav" ]]; then
            CURRENT_USER="$u_sav"
        else
            echo -e "${C_R}❌ ACCESO DENEGADO.${C_0}"
            exit 1
        fi
    fi
}

# --- CAPA 6: GESTOR DE RECURSOS (COMANDOS INMORTALES) ---
sys_internals() {
    local cmd_in="$1"
    local arg_in="$2"
    
    case "$cmd_in" in
        "sys.stats")
            local up=$(($(date +%s) - START_TIME))
            echo -e "${C_V}--- ESTADO DEL NÚCLEO ---${C_0}"
            echo "Distribución: $SYS_VERSION"
            echo "Arranque: $up segundos activo"
            echo "Tabla Activa: $(basename "$CONFIG_JSON")"
            return 0 ;;
        "sys.tech") show_tech_specs; return 0 ;;
        "sys.logs") tail -n 25 "$LOG_FILE"; return 0 ;;
        # LIBRERÍA INMORTAL (No importa si el JSON está vacío, estos siempre funcionan)
        "usar")
            if [ -z "$arg_in" ]; then echo '⚠️ Uso: usar nombre.json'; return 0; fi
            if [ -f "$ROOT_DIR/json/$arg_in" ]; then 
                echo "$arg_in" > "$ROOT_DIR/config/active.conf"
                echo "✅ Tabla '$arg_in' activada. Reinicia VerduraOS."
            else 
                echo "❌ No existe $ROOT_DIR/json/$arg_in"
            fi
            return 0 ;;
        "instalar.tabla")
            if [ -z "$arg_in" ]; then echo '⚠️ Uso: instalar.tabla [nombre.json]'; return 0; fi
            wget -q "https://raw.githubusercontent.com/loslocos817yt-star/apps/main/clmandosV/$arg_in" -O "$ROOT_DIR/json/$arg_in" && echo "✅ Tabla '$arg_in' descargada." || echo '❌ Error al conectar.'
            return 0 ;;
    esac
    return 1
}

# --- CAPA 7: ARRANQUE Y LECTURA DINÁMICA DE VERSIÓN ---
mkdir -p "$APPS_DIR" "$ROOT_DIR/json" "$USER_DIR" "$CONF_DIR" "$BACKUP_DIR"
touch "$LOG_FILE"
kernel_authenticate

# Determinar tabla activa
[ -f "$CONF_FILE" ] && T_LOAD=$(cat "$CONF_FILE") || T_LOAD="comandos.json"
export CONFIG_JSON="$ROOT_DIR/json/$T_LOAD"

# Si no existe, creamos un JSON base con versión por defecto
if [ ! -f "$CONFIG_JSON" ]; then
    echo '{"Version":"1.0-RECOVERY", "comandos":[]}' > "$CONFIG_JSON"
fi

# EXTRAER VERSIÓN DINÁMICA DEL JSON (La magia ocurre aquí)
export SYS_VERSION=$(jq -r '.Version // "Unknown-Core"' "$CONFIG_JSON" 2>/dev/null)

clear
echo -e "${C_V}🥦 VerduraOS | $SYS_VERSION${C_0}"
echo -e "${C_G}Librería principal inmortal activa. Blindaje OK.${C_0}"
echo "----------------------------------------------------------------"

# --- BUCLE DE CONTROL DE EVENTOS ---
while true; do
    T_LOG=$(date +%H:%M:%S)
    read -p "$(echo -e "${C_V}[$T_LOG] ${C_C}${CURRENT_USER}${C_V}@VerduraOS: ${C_0}")" input
    
    [ -z "$input" ] && continue
    read -r -a p <<< "$input"
    cmd="${p[0]}"; args="${p[@]:1}"

    [[ "$cmd" == "salir" || "$cmd" == "exit" ]] && break

    # 1. Comandos Nativos / Inmortales (Pasa el primer argumento también)
    if sys_internals "$cmd" "${p[1]}"; then continue; fi

    # 2. Comandos Externos (JSON Engine)
    accion=$(jq -r --arg c "$cmd" '.comandos[] | select(.comando == $c) | .accion' "$CONFIG_JSON" 2>/dev/null)

    if [[ -n "$accion" && "$accion" != "null" ]]; then
        if is_action_secure "$accion"; then
            bash -c "$accion" _ $args
        fi
    else
        echo -e "${C_R}❌ Error: '$cmd' no existe en $SYS_VERSION.${C_0}"
    fi
done
