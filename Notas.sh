#!/bin/bash

NOTAS_FILE="$APPS_DIR/mis_notas.txt"

# Función para el menú
mostrar_menu() {
    echo "---------------------------"
    echo "  📝 BLOC DE NOTAS VERDURA"
    echo "---------------------------"
    echo "1) Ver todas las notas"
    echo "2) Añadir nueva nota"
    echo "3) Limpiar bloc de notas"
    echo "4) Salir"
    echo "---------------------------"
}

while true; do
    mostrar_menu
    read -p "Elige una opción (1-4): " op
    
    case $op in
        1)
            if [ -f "$NOTAS_FILE" ]; then
                echo -e "\n--- TUS ANOTACIONES ---"
                cat -n "$NOTAS_FILE"
                echo -e "-----------------------\n"
            else
                echo "📭 El bloc está vacío."
            fi
            ;;
        2)
            read -p "Escribe tu nota: " texto
            echo "$(date +'%d/%m/%Y %H:%M') - $texto" >> "$NOTAS_FILE"
            echo "✅ Nota guardada."
            ;;
        3)
            rm -f "$NOTAS_FILE"
            echo "🧹 Notas eliminadas."
            ;;
        4)
            echo "Cerrando Bloc..."
            break
            ;;
        *)
            echo "❌ Opción no válida."
            ;;
    esac
done
