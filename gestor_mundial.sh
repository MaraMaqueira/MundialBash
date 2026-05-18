#!/bin/bash

# Colores
ROJO='\033[1;31m'
VERDE='\033[1;32m'
AMARILLO='\033[1;33m'
BLANCO='\033[1;37m'
CELESTE='\033[1;36m'
RESET='\033[0m'

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
    [[ "$1" =~ [0-9] ]]
}

existe_equipo() {
    grep -iq "^EQUIPO:$1" "$ARCHIVO"
}

listar_equipos() {
    echo -e "${BLANCO}----- EQUIPOS -----${RESET}"
    grep "^EQUIPO:" "$ARCHIVO" | cut -d":" -f2 | nl
}

mostrar_campeon() {
    echo -e "${BLANCO}----- CAMPEÓN ACTUAL -----${RESET}"
    campeon=$(grep "^CAMPEON:" "$ARCHIVO" | cut -d":" -f2 | tr '[:lower:]' '[:upper:]')

    if [ "$campeon" = "ARGENTINA" ]; then
        # A=blanca R=celeste G=blanca E=celeste N=amarilla T=blanca I=celeste N=blanca A=celeste
        echo -e "\n        ${BLANCO}A${RESET}${CELESTE}R${RESET}${BLANCO}G${RESET}${CELESTE}E${RESET}${AMARILLO}N${RESET}${BLANCO}T${RESET}${CELESTE}I${RESET}${BLANCO}N${RESET}${CELESTE}A${RESET}"
    else
        echo "$campeon"
    fi
}

registrar_equipo() {
    read -p "Nombre del equipo: " nombre

    if [ -z "$nombre" ]; then
        echo -e "${ROJO}No puede estar vacío${RESET}"
        return
    fi
    
    if es_numero "$nombre"; then
        echo -e "${ROJO}Los equipos no pueden ser números${RESET}"
        return
    fi

    cantidad=$(grep "^EQUIPO:" "$ARCHIVO" | wc -l)

    if [ "$cantidad" -ge 15 ]; then
        echo -e "${ROJO}Máximo de equipos alcanzado${RESET}"
        return
    fi

    if existe_equipo "$nombre"; then
        echo -e "${ROJO}El equipo ya existe${RESET}"
    else
        echo "EQUIPO:$nombre" >> "$ARCHIVO"
        echo -e "${VERDE}Equipo registrado correctamente${RESET}"
    fi
}

registrar_partido() { 
    read -p "Equipo 1: " eq1
    read -p "Goles equipo 1: " g1

        if ! existe_equipo "$eq1" && ! es_numero "$g1"; then
            echo -e "${ROJO}Ningún dato es válido${RESET}"
            return
        fi

        if ! existe_equipo "$eq1"; then
            echo -e "${ROJO}Equipo 1 no existe${RESET}"
            return
        fi

        if ! es_numero "$g1"; then
            echo -e "${ROJO}Los goles deben ser números${RESET}"
            return
        fi

    read -p "Equipo 2: " eq2
    read -p "Goles equipo 2: " g2

        if ! existe_equipo "$eq2" && ! es_numero "$g2"; then
            echo -e "${ROJO}Ningún dato es válido${RESET}"
            return
        fi

        if ! existe_equipo "$eq2"; then
            echo -e "${ROJO}Equipo 2 no existe${RESET}"
            return
        fi

        if ! es_numero "$g2"; then
            echo -e "${ROJO}Los goles deben ser números${RESET}"
            return
        fi

    if [ "$eq1" = "$eq2" ]; then
        echo -e "${ROJO}Un equipo no puede jugar contra sí mismo${RESET}"
        return
    fi

    echo "PARTIDO:$eq1 vs $eq2 ($g1 - $g2)" >> "$ARCHIVO"
    echo -e "${VERDE}Partido registrado correctamente${RESET}"
}

ver_historial() {
    echo -e "${BLANCO}----- HISTORIAL -----${RESET}"
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
        echo -e "${ROJO}No puede estar vacío${RESET}"
        return
    fi

    if existe_equipo "$nombre"; then
        echo -e "${VERDE}El equipo está registrado${RESET}"
    else
        echo -e "${ROJO}El equipo no existe${RESET}"
    fi
}

cantidad_partidos() {
    total=$(grep "^PARTIDO:" "$ARCHIVO" | wc -l)
    echo "Total de partidos jugados: $total"
}

menu() {
    echo ""
    echo -e "${BLANCO}===== GESTOR DEL MUNDIAL =====${RESET}"
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
        8) echo -e "Saliendo...\n"; sleep 0.7;
echo "=========== Autores ===========
=                             =
=  Mara Maqueira (354709)     =
=  Brian del Pino (329242)    =
=  Facundo Martinez (292207)  =
=                             =
==============================="; break ;;
        *) echo -e "${ROJO}Opción inválida${RESET}" ;;
    esac
done
done
