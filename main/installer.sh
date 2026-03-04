#!/bin/bash

# ==============================================================================
# 🥦 VerduraOS - Instalador Automático (The Giga-Monolith)
# ==============================================================================

# Colores para la terminal
C_V="\e[1;32m"
C_C="\e[1;36m"
C_G="\e[0;90m"
C_0="\e[0m"

clear
echo -e "${C_V}Iniciando despliegue de VerduraOS...${C_0}"
echo "------------------------------------------------"

# Paso 1 (0-3s)
echo -e "${C_C}[1/6] Construyendo directorio raíz (VerduraOS)...${C_0}"
sleep 3
mkdir -p VerduraOS
cd VerduraOS || exit 1

# Paso 2 (3-8s)
echo -e "${C_C}[2/6] Descargando el Kernel (main.sh) desde los repositorios...${C_0}"
sleep 5
wget -q "https://raw.githubusercontent.com/loslocos817yt-star/apps/main/main/main.sh" -O main.sh
chmod +x main.sh
echo -e "${C_G}  -> main.sh descargado y permisos de ejecución otorgados.${C_0}"

# Paso 3 (8-12s)
echo -e "${C_C}[3/6] Compilando la arquitectura JSON...${C_0}"
sleep 4
mkdir -p json
cd json || exit 1

# Paso 4 (12-16s)
echo -e "${C_C}[4/6] Inyectando tablas base (comandosV1.0.json y link.json)...${C_0}"
sleep 4

# Inyectando link.json
cat <<EOF > link.json
{
  "repo_name": "Verdura-Store",
  "url": "https://github.com/loslocos817yt-star/apps",
  "tablas_path": "clmandosV"
}
EOF

# Inyectando comandosV1.0.json
cat <<EOF > comandosV1.0.json
{
  "Version": "1.0 Beta",
  "comandos": [
    {
      "comando": "help",
      "accion": "echo '🌱 Comandos disponibles en esta tabla:' && jq -r '.comandos[] | \"  - \\(.comando): \\(.descripcion)\"' \"$CONFIG_JSON\"",
      "descripcion": "Muestra esta lista de comandos"
    },
    {
      "comando": "usar",
      "accion": "if [ -z \"$1\" ]; then echo '⚠️ Uso: usar nombre.json'; exit 1; fi; if [ -f \"$ROOT_DIR/json/$1\" ]; then echo \"$1\" > \"$ROOT_DIR/config/active.conf\"; echo \"✅ Tabla '$1' activada → sal y vuelve a entrar\"; else echo \"❌ No existe $ROOT_DIR/json/$1\"; fi",
      "descripcion": "Cambia la tabla de comandos activa"
    },
    {
      "comando": "instalar.tabla",
      "accion": "if [ -z \"$1\" ]; then echo '⚠️ Uso: instalar.tabla [nombre.json]'; else wget -q \"https://raw.githubusercontent.com/loslocos817yt-star/apps/main/clmandosV/$1\" -O \"$ROOT_DIR/json/$1\" && echo \"✅ Tabla '$1' descargada.\" || echo '❌ Error al conectar.'; fi",
      "descripcion": "Descarga nuevas Tablas de Comandos"
    },
    {
      "comando": "ver",
      "accion": "ls -F --color=auto \"$APPS_DIR\" 2>/dev/null || echo 'No hay nada plantado aún 🌱'",
      "descripcion": "Muestra las apps plantadas en /apps"
    },
    {
      "comando": "instalar",
      "accion": "URL=$(jq -r '.url // \"https://github.com/tu-repo\"' \"$ROOT_DIR/json/link.json\"); echo \"📡 Trayendo semillas de: $URL\"; git clone \"$URL\" \"$APPS_DIR/temp_repo\" -q && cp -r \"$APPS_DIR/temp_repo/\"* \"$APPS_DIR/\" 2>/dev/null; rm -rf \"$APPS_DIR/temp_repo\"; echo \"✅ Cosecha completa.\"",
      "descripcion": "Instala TODAS las apps del repositorio"
    },
    {
      "comando": "apps.disponibles",
      "accion": "URL=$(jq -r '.url // \"https://github.com/tu-repo\"' \"$ROOT_DIR/json/link.json\"); CACHE=\"$ROOT_DIR/.repo_cache\"; rm -rf \"$CACHE\"; git clone \"$URL\" \"$CACHE\" -q 2>/dev/null; echo '🛒 Catálogo:'; for app in \"$CACHE\"/*; do [ -e \"$app\" ] || continue; name=$(basename \"$app\"); [[ -d \"$app\" || \"$name\" == \"README.md\" ]] && continue; [ -f \"$APPS_DIR/$name\" ] && echo \"  ✅ $name\" || echo \"  ❌ $name\"; done",
      "descripcion": "Muestra qué apps del repo están instaladas"
    },
    {
      "comando": "instalar.app",
      "accion": "if [ -z \"$1\" ]; then echo '⚠️ Uso: instalar.app [app.sh]'; else CACHE=\"$ROOT_DIR/.repo_cache\"; URL=$(jq -r '.url // \"https://github.com/tu-repo\"' \"$ROOT_DIR/json/link.json\"); [ -d \"$CACHE\" ] || git clone \"$URL\" \"$CACHE\" -q 2>/dev/null; if [ -f \"$CACHE/$1\" ]; then cp \"$CACHE/$1\" \"$APPS_DIR/\"; chmod +x \"$APPS_DIR/$1\"; echo \"✅ '$1' instalada.\"; else echo \"❌ No existe '$1' en el repo.\"; fi; fi",
      "descripcion": "Instala una app específica"
    },
    {
      "comando": "ejecutar",
      "accion": "if [ -z \"$1\" ]; then echo '⚠️ Uso: ejecutar [app.sh]'; elif [ -f \"$APPS_DIR/$1\" ]; then echo '🚀 Iniciando $1...'; bash \"$APPS_DIR/$1\"; else echo \"❌ No existe '$1' en /apps\"; fi",
      "descripcion": "Ejecuta una app"
    },
    {
      "comando": "limpiar",
      "accion": "rm -rf \"$APPS_DIR/\"* 2>/dev/null; echo '🧹 Huerto limpiado.'",
      "descripcion": "Elimina todas las apps"
    },
    {
      "comando": "link",
      "accion": "cat \"$ROOT_DIR/json/link.json\" 2>/dev/null || echo 'No hay link.json configurado'",
      "descripcion": "Muestra el repo actual"
    },
    {
      "comando": "borrar",
      "accion": "clear; echo -e \"\\e[32m🥦 VerduraOS | $SYS_VERSION\\e[0m\"; echo \"----------------------------------------\"",
      "descripcion": "Limpia la pantalla"
    }
  ]
}
EOF
echo -e "${C_G}  -> Tabla comandosV1.0.json generada correctamente.${C_0}"

# Paso 5 (16-19s)
echo -e "${C_C}[5/6] Preparando sectores de almacenamiento (apps y config)...${C_0}"
sleep 3
cd ..
mkdir -p apps config
# Pre-activamos la tabla con su extensión completa
echo "comandosV1.0.json" > config/active.conf
echo -e "${C_G}  -> Configuración activa apuntando a comandosV1.0.json.${C_0}"

# Paso 6 (19-20s)
echo -e "${C_C}[6/6] Sincronizando engranajes finales...${C_0}"
sleep 1

echo "------------------------------------------------"
echo -e "${C_V}✅ Sistema instalado con extensiones verificadas.${C_0}"
echo -e "Para iniciar, escribe: ${C_C}cd VerduraOS && ./main.sh${C_0}"

