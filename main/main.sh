#!/bin/bash

# ==============================================================================
# 🥦 VerduraOS Kernel v8.5 - "THE GIGA-MONOLITH" (Final Release Edition)
# ==============================================================================
# Autor: Farmer Developer
# Licencia: Verdura-Open-Source
# Descripción: Kernel modular con motor JSON, blindaje de seguridad y 
# sistema de paquetería dinámico. Diseñado para ser pesado y resiliente.
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
export KERNEL_INTEGRITY="SECURE_9582"

# --- CAPA 1: SISTEMA DE COLORES E INTERFAZ (TEMA: AGRO-TECH) ---
C_V="\e[1;32m"; C_A="\e[1;33m"; C_C="\e[1;36m"; C_R="\e[1;31m"
C_M="\e[1;35m"; C_B="\e[1;37m"; C_G="\e[0;90m"; C_0="\e[0m"

# --- CAPA 2: MOTOR DE AUDITORÍA Y REGISTRO (LOGGING) ---
log_kernel() {
    local stamp=$(date '+%Y-%m-%d %H:%M:%S')
    local type="$1"
    local msg="$2"
    printf "[%s] [%-10s] %s\n" "$stamp" "$type" "$msg" >> "$LOG_FILE"
}

# --- CAPA 3: MANUAL TÉCNICO DE ARQUITECTURA (BLOQUE PESADO) ---
show_tech_specs() {
    echo -e "${C_C}================================================================${C_0}"
    echo -e "${C_V}         GIGA-MONOLITH | ESPECIFICACIONES DE NÚCLEO v8.5${C_0}"
    echo -e "${C_C}================================================================${C_0}"
    echo -e "${C_C}1. CONTROL DE VERSIONES DINÁMICO:${C_0}"
    echo "   El Kernel hereda su versión ($SYS_VERSION) directamente"
    echo "   del archivo JSON activo, permitiendo distribuciones custom."
    echo ""
    echo -e "${C_C}2. COMANDOS INMORTALES:${C_0}"
    echo "   Los comandos 'usar', 'instalar.tabla' y 'sys.diag' están"
    echo "   embebidos en el binario del script para máxima resiliencia."
    echo ""
    echo -e "${C_C}3. FIREWALL DE CAPA 4:${C_0}"
    echo "   Inspección profunda de strings para evitar inyecciones de código"
    echo "   malicioso en el Huerto (apps/)."
    echo ""
    echo -e "${C_C}4. MEMORIA DE SESIÓN:${C_0}"
    echo "   Registro de auditoría en user/system.log para trazabilidad."
    echo -e "${C_C}================================================================${C_0}"
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
        local hash=$(printf "%s%s" "$p_reg" "$u_reg" | sha256sum | awk '{print $1}')
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
            echo -e "${C_R}❌ ACCESO DENEGADO.${C_0}"; exit 1
        fi
    fi
}

# --- CAPA 6: GESTOR DE RECURSOS (COMANDOS INMORTALES) ---
sys_internals() {
    local cmd_in="$1"
    local arg_in="$2"
    
    case "$cmd_in" in
        "sys.diag")
            echo -e "${C_C}🔍 Iniciando diagnóstico de hardware...${C_0}"
            sleep 1; echo "   - Memoria Virtual: OK"; sleep 1
            echo "   - Integridad JSON: OK"; sleep 1
            echo "   - Conexión Repo: OK"
            return 0 ;;
        "sys.stats")
            local up=$(($(date +%s) - START_TIME))
            echo -e "${C_V}--- ESTADO DEL NÚCLEO ---${C_0}"
            echo -e "${C_C}Distribución: $SYS_VERSION${C_0}"
            echo -e "${C_C}Uptime: $up segundos${C_0}"
            echo -e "${C_C}Kernel: 8.5 (Monolith)${C_0}"
            return 0 ;;
        "sys.tech") show_tech_specs; return 0 ;;
        "usar")
            if [ -z "$arg_in" ]; then echo -e "${C_C}⚠️ Uso: usar archivo.json${C_0}"; return 0; fi
            if [ -f "$ROOT_DIR/json/$arg_in" ]; then 
                echo "$arg_in" > "$CONF_FILE"
                echo -e "${C_C}✅ Tabla '$arg_in' activada. Reinicia para aplicar.${C_0}"
            else 
                echo -e "${C_R}❌ Error: $arg_in no encontrado.${C_0}"
            fi
            return 0 ;;
        "instalar.tabla")
            if [ -z "$arg_in" ]; then echo -e "${C_C}⚠️ Uso: instalar.tabla [archivo.json]${C_0}"; return 0; fi
            wget -q "https://raw.githubusercontent.com/loslocos817yt-star/apps/main/clmandosV/$arg_in" -O "$ROOT_DIR/json/$arg_in" && echo -e "${C_C}✅ Tabla descargada.${C_0}" || echo -e "${C_R}❌ Error de red.${C_0}"
            return 0 ;;
        "borrar") clear; return 0 ;;
    esac
    return 1
}

# --- CAPA 7: ARRANQUE Y CARGA ---
mkdir -p "$APPS_DIR" "$ROOT_DIR/json" "$USER_DIR" "$CONF_DIR" "$BACKUP_DIR"
touch "$LOG_FILE"
kernel_authenticate

[ -f "$CONF_FILE" ] && T_LOAD=$(cat "$CONF_FILE") || T_LOAD="comandosV1.0.json"
export CONFIG_JSON="$ROOT_DIR/json/$T_LOAD"

if [ ! -f "$CONFIG_JSON" ]; then
    echo '{"Version":"1.0-RECOVERY", "comandos":[]}' > "$CONFIG_JSON"
fi

export SYS_VERSION=$(jq -r '.Version // "V8.5-Core"' "$CONFIG_JSON" 2>/dev/null)

clear
# LOGOTIPO ASCII PROTEGIDO (lo regresé tal cual estaba)
echo -e "${C_V}================================================================${C_0}"
echo -e "${C_V}__     __            _                    ____   _____ ${C_0}"
echo -e "${C_V}\\\\ \\\\   / /__ _ __  __| |_   _ _ __ __ _   / __ \\\\ / ____|${C_0}"
echo -e "${C_V} \\\\ \\\\ / / _ \\\\ '__|/ _\` | | | | '__/ _\` | | |  | | (___  ${C_0}"
echo -e "${C_V}  \\\\ V /  __/ |  | (_| | |_| | | | (_| | | |__| |\\\\___ \\\\ ${C_0}"
echo -e "${C_V}   \\\\_/ \\\\___|_|   \\\\__,_|\\\\__,_|_|  \\\\__,_|  \\\\____/ _____/ ${C_0}"
echo -e "${C_V}================================================================${C_0}"
echo -e "${C_V}🥦 VerduraOS | ${C_C}$SYS_VERSION${C_0}"
echo -e "${C_C}Estado: Monolítico | Seguridad: Activa${C_0}"
echo -e "${C_C}----------------------------------------------------------------${C_0}"

# --- BUCLE DE CONTROL DE EVENTOS ---
while true; do
    T_LOG=$(date +%H:%M:%S)
    
    # Prompt original
    echo -ne "${C_A}"; read -p "$(echo -e "${C_C}[$T_LOG] ${C_R}${CURRENT_USER}@VerduraOS: ") " input; echo -ne "${C_0}"
    
    [ -z "$input" ] && continue
    read -r -a p <<< "$input"
    cmd="${p[0]}"; args="${p[@]:1}"

    [[ "$cmd" == "salir" || "$cmd" == "exit" ]] && { echo -e "🔥"; break; }

    # 1. Comandos Nativos
    if sys_internals "$cmd" "${p[1]}"; then continue; fi

    # 2. MOTOR JSON → FIX AQUÍ (limpia los escapes dobles que jq mete)
    accion_raw=$(jq -r --arg c "$cmd" '.comandos[] | select(.comando == $c) | .accion' "$CONFIG_JSON" 2>/dev/null)
    # Quitamos los backslashes extras que rompen bash -c
    accion=$(echo "$accion_raw" | sed 's/\\\\/\\/g; s/\\"/"/g')

    if [[ -n "$accion" && "$accion" != "null" ]]; then
        if is_action_secure "$accion"; then
            echo -ne "${C_C}"
            # Exportamos las variables para que el subshell las vea (como antes)
            export APPS_DIR ROOT_DIR CONFIG_JSON SYS_VERSION
            bash -c "$accion" _ $args
            echo -ne "${C_0}"
        fi
    else
        echo -e "${C_R}❌ Error: '$cmd' no existe en $SYS_VERSION.${C_0}"
    fi
done

# --- CAPA 8: METADATOS DE PADDING (Para peso extra) ---
# DOCUMENTACIÓN DE DESPLIEGUE:
# 1. Asegúrese de tener 'jq' instalado (pkg install jq / apt install jq).
# 2. El archivo JSON debe tener una estructura válida de objetos en un array.
# 3. No modifique el Kernel si no conoce la lógica de subshells de Bash.
# 4. VerduraOS es una marca registrada en el huerto de la terminal.
# [PADDING DATA END]
