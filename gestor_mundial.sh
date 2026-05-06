#!/bin/bash

ARCHIVO="mundial.txt"

inicializar_archivo() {
    if [ ! -f "$ARCHIVO" ]; then
        echo "CAMPEON:Argentina" > "$ARCHIVO"
        echo "EQUIPO:Argentina" >> "$ARCHIVO"
        echo "EQUIPO:Francia" >> "$ARCHIVO"
        echo "EQUIPO:Brasil" >> "$ARCHIVO"
    fi
}

es_numero() {
    [[ "$1" =~ ^[0-9]+$ ]]
}

existe_equipo() {
    grep -iq "^EQUIPO:$1" "$ARCHIVO"
}

listar_equipos() {
    echo "----- EQUIPOS -----"
    grep "^EQUIPO:" "$ARCHIVO" | cut -d":" -f2 | nl
}

mostrar_campeon() {
    echo "----- CAMPEÓN ACTUAL -----"
    grep "^CAMPEON:" "$ARCHIVO" | cut -d":" -f2
}

registrar_equipo() {
    read -p "Nombre del equipo: " nombre

    if [ -z "$nombre" ]; then
        echo "No puede estar vacío"
        return
    fi

    cantidad=$(grep "^EQUIPO:" "$ARCHIVO" | wc -l)

    if [ "$cantidad" -ge 15 ]; then
        echo "Máximo de equipos alcanzado"
        return
    fi

    if existe_equipo "$nombre"; then
        echo "El equipo ya existe"
    else
        echo "EQUIPO:$nombre" >> "$ARCHIVO"
        echo "Equipo registrado correctamente"
    fi
}

registrar_partido() {
    read -p "Equipo 1: " eq1
    read -p "Goles equipo 1: " g1
    read -p "Equipo 2: " eq2
    read -p "Goles equipo 2: " g2

    if [ -z "$eq1" ] || [ -z "$eq2" ] || [ -z "$g1" ] || [ -z "$g2" ]; then
        echo "Datos inválidos"
        return
    fi

    if ! existe_equipo "$eq1" || ! existe_equipo "$eq2"; then
        echo "Uno o ambos equipos no existen"
        return
    fi

    if ! es_numero "$g1" || ! es_numero "$g2"; then
        echo "Los goles deben ser números"
        return
    fi

    echo "PARTIDO:$eq1 $g1 $eq2 $g2" >> "$ARCHIVO"
    echo "Partido registrado correctamente"
}

ver_historial() {
    echo "----- HISTORIAL -----"
    partidos=$(grep "^PARTIDO:" "$ARCHIVO")

    if [ -z "$partidos" ]; then
        echo "No hay partidos registrados"
    else
        echo "$partidos" | cut -d":" -f2 | nl
    fi
}

buscar_equipo() {
    read -p "Nombre del equipo: " nombre

    if [ -z "$nombre" ]; then
        echo "No puede estar vacío"
        return
    fi

    if existe_equipo "$nombre"; then
        echo "El equipo está registrado"
    else
        echo "El equipo no existe"
    fi
}

cantidad_partidos() {
    total=$(grep "^PARTIDO:" "$ARCHIVO" | wc -l)
    echo "Total de partidos jugados: $total"
}

menu() {
    echo ""
    echo "===== GESTOR DEL MUNDIAL ====="
    echo "1. Listar equipos"
    echo "2. Mostrar campeón"
    echo "3. Registrar equipo"
    echo "4. Registrar partido"
    echo "5. Ver historial"
    echo "6. Buscar equipo"
    echo "7. Cantidad de partidos"
    echo "8. Salir"
}

inicializar_archivo

while true; do
    menu
    read -p "Opción: " op

    case $op in
        1) listar_equipos ;;
        2) mostrar_campeon ;;
        3) registrar_equipo ;;
        4) registrar_partido ;;
        5) ver_historial ;;
        6) buscar_equipo ;;
        7) cantidad_partidos ;;
        8) echo "Saliendo..."; break ;;
        *) echo "Opción inválida" ;;
    esac
done
