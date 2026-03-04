#!/bin/bash

# ==============================================================================
# 🥦 VerduraOS Kernel v8.6 - "GIGA-MONOLITH BLINDADO" (Aceite de oliva extra)
# ==============================================================================
# Cambios: quoting limpio, motor JSON más robusto, firewall más estricto
# ==============================================================================

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
export KERNEL_INTEGRITY="SECURE_9583"

# Colores agro-tech
C_V="\e[1;32m"; C_A="\e[1;33m"; C_C="\e[1;36m"; C_R="\e[1;31m"
C_M="\e[1;35m"; C_B="\e[1;37m"; C_G="\e[0;90m"; C_0="\e[0m"

log_kernel() {
    local stamp=$(date '+%Y-%m-%d %H:%M:%S')
    printf "[%s] [%-10s] %s\n" "$stamp" "$1" "$2" >> "$LOG_FILE"
}

show_tech_specs() {
    echo -e "${C_C}================================================================${C_0}"
    echo -e "${C_V}         GIGA-MONOLITH BLINDADO | v8.6${C_0}"
    echo -e "${C_C}================================================================${C_0}"
    echo -e "${C_C}• Motor JSON: quoting limpio + subshell seguro${C_0}"
    echo -e "${C_C}• Firewall: +10 patrones peligrosos${C_0}"
    echo -e "${C_C}• Comandos inmortales: usar, instalar.tabla, sys.*${C_0}"
    echo -e "${C_C}• Integridad: $KERNEL_INTEGRITY${C_0}"
    echo -e "${C_C}================================================================${C_0}"
}

# Firewall más gordo
SAFE_MODE=true
DANGER_DATABASE=(
    "rm -rf /" "sudo " "dd " "mkfs" ":(){:|:&};:" "shutdown" "reboot" 
    "nc -e" "bash -i" "curl * | bash" "wget * | bash" "chmod 777" ">: " 
    ">!" "kill -9 1" "rm -rf *" "mv / /" "alias " "fork bomb" "chroot" 
    "iptables" "ufw" "chown" "nohup" "disown" ">/dev/tcp" "<(curl"
)

is_action_secure() {
    [ "$SAFE_MODE" != "true" ] && return 0
    local input="$1"
    for pat in "${DANGER_DATABASE[@]}"; do
        if echo "$input" | grep -F -q "$pat"; then
            echo -e "${C_R}🚨 BLOQUEADO: patrón peligroso → $pat${C_0}"
            log_kernel "SECURITY" "Bloqueo: $pat en '$input'"
            return 1
        fi
    done
    return 0
}

kernel_authenticate() {
    mkdir -p "$USER_DIR" "$CONF_DIR" "$APPS_DIR" "$BACKUP_DIR" "$ROOT_DIR/json"
    touch "$LOG_FILE"

    if [ ! -f "$USER_KEY" ]; then
        echo -e "${C_V}🌱 Primer arranque → creando agricultor${C_0}"
        read -p "Nombre del Agricultor: " u_reg
        while true; do
            read -s -p "Llave maestra: " p_reg; echo
            read -s -p "Confirma llave: " p_conf; echo
            [ "$p_reg" = "$p_conf" ] && break
            echo -e "${C_R}❌ Llaves no coinciden${C_0}"
        done
        hash=$(printf "%s%s" "$p_reg" "$u_reg" | sha256sum | cut -d' ' -f1)
        echo "$u_reg:$hash" > "$USER_KEY"
        chmod 600 "$USER_KEY"
        CURRENT_USER="$u_reg"
    else
        IFS=':' read -r u_sav h_sav < "$USER_KEY"
        echo -e "${C_V}🔒 VERDURAOS - Ingresa tus credenciales${C_0}"
        read -p "Agricultor: " u_in
        read -s -p "Llave: " p_in; echo
        h_in=$(printf "%s%s" "$p_in" "$u_in" | sha256sum | cut -d' ' -f1)
        if [ "$u_in" = "$u_sav" ] && [ "$h_in" = "$h_sav" ]; then
            CURRENT_USER="$u_sav"
        else
            echo -e "${C_R}❌ ACCESO DENEGADO${C_0}"; exit 1
        fi
    fi
}

# Comandos inmortales (prioridad alta)
sys_internals() {
    local cmd="$1" arg="${2:-}"
    case "$cmd" in
        sys.diag)   echo -e "${C_C}🔍 Diagnóstico rápido:${C_0} OK"; return 0 ;;
        sys.stats)
            up=$(( $(date +%s) - START_TIME ))
            echo -e "${C_V}Uptime:${C_0} $up seg | Versión: $SYS_VERSION | Kernel: 8.6 Blindado"
            return 0 ;;
        sys.tech)   show_tech_specs; return 0 ;;
        usar)
            [ -z "$arg" ] && { echo -e "${C_A}⚠️  usar <archivo.json>${C_0}"; return 0; }
            if [ -f "$ROOT_DIR/json/$arg" ]; then
                echo "$arg" > "$CONF_FILE"
                echo -e "${C_V}✅ Tabla '$arg' activada (reinicia)${C_0}"
            else
                echo -e "${C_R}❌ No existe $arg${C_0}"
            fi
            return 0 ;;
        instalar.tabla)
            [ -z "$arg" ] && { echo -e "${C_A}⚠️  instalar.tabla <nombre.json>${C_0}"; return 0; }
            url="https://raw.githubusercontent.com/loslocos817yt-star/apps/main/clmandosV/$arg"
            wget -q "$url" -O "$ROOT_DIR/json/$arg" && echo -e "${C_V}✅ Descargada${C_0}" || echo -e "${C_R}❌ Falló${C_0}"
            return 0 ;;
        borrar) clear; return 0 ;;
    esac
    return 1
}

# ==============================================================================
# ARRANQUE
# ==============================================================================

kernel_authenticate

[ -s "$CONF_FILE" ] && T_LOAD=$(cat "$CONF_FILE") || T_LOAD="comandosV1.0.json"
export CONFIG_JSON="$ROOT_DIR/json/$T_LOAD"

[ -f "$CONFIG_JSON" ] || echo '{"Version":"RECOVERY","comandos":[]}' > "$CONFIG_JSON"

export SYS_VERSION=$(jq -r '.Version // "8.6-BLINDADO"' "$CONFIG_JSON" 2>/dev/null || echo "8.6-RECOVERY")

clear
echo -e "${C_V}🥦 VerduraOS v$SYS_VERSION - Blindado con aceite${C_0}"
echo -e "${C_C}Bienvenid@ $CURRENT_USER | Seguridad: ON | $(date '+%Y-%m-%d %H:%M')${C_0}"
echo

while true; do
    T_LOG=$(date +%H:%M:%S)
    echo -ne "${C_A}"
    read -p "$(echo -e "${C_C}[$T_LOG] ${C_R}${CURRENT_USER}@VerduraOS ${C_A}> " )" input
    echo -ne "${C_0}"

    [ -z "$input" ] && continue
    read -r -a partes <<< "$input"
    cmd="${partes[0]}"
    args=("${partes[@]:1}")

    [[ "$cmd" == "salir" || "$cmd" == "exit" || "$cmd" == "q" ]] && { echo -e "${C_V}🔥 Nos vemos en el huerto${C_0}"; break; }

    if sys_internals "$cmd" "${args[0]}"; then
        continue
    fi

    # Motor JSON blindado
    accion=$(jq -r --arg c "$cmd" '.comandos[] | select(.comando == $c) | .accion' "$CONFIG_JSON" 2>/dev/null)

    if [[ -n "$accion" && "$accion" != "null" ]]; then
        if is_action_secure "$accion"; then
            echo -ne "${C_C}"
            # Exportamos todo lo necesario al subshell
            export APPS_DIR ROOT_DIR CONFIG_JSON SYS_VERSION CURRENT_USER
            bash -c "$accion" verdura "${args[@]}"  # <-- "$@" pasa todos los argumentos limpios
            echo -ne "${C_0}"
        fi
    else
        echo -e "${C_R}❌ '$cmd' no existe en $SYS_VERSION${C_0}"
    fi
done
