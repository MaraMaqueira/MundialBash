# Gestor del Mundial - Bash Script

## Integrantes

* Mara Maqueira 
* Brian del Pino 
* Facundo Martinez

## Descripción

Este proyecto consiste en el desarrollo de un script en Bash que simula un sistema de gestión de un Mundial de fútbol.
El sistema permite interactuar mediante un menú con distintas funcionalidades como registrar equipos, partidos y consultar información almacenada.

Toda la información se guarda en un único archivo (`mundial.txt`), cumpliendo con los requisitos del obligatorio.

---

## Funcionalidades

* Listar equipos registrados
* Mostrar el campeón actual
* Registrar nuevos equipos (máximo 15)
* Registrar partidos entre equipos
* Ver historial de partidos
* Buscar un equipo
* Mostrar cantidad total de partidos
* Salir del sistema

---

## Estructura del Proyecto

* `gestor_mundial.sh` → Script principal
* `mundial.txt` → Archivo de almacenamiento de datos

Formato del archivo:

* `CAMPEON:Nombre`
* `EQUIPO:Nombre`
* `PARTIDO:Equipo1 Goles Equipo2 Goles`

---

## Requisitos Técnicos

* Uso de funciones para cada funcionalidad
* Validación de entradas (no vacíos)
* Validación de goles como números
* Verificación de existencia de equipos
* Uso de estructuras de control (`if`, `case`, `while`)

---

## Ejecución

Dar permisos al script:

```bash
chmod +x gestor_mundial.sh
```

Ejecutar:

```bash
./gestor_mundial.sh
```

---

## Consideraciones

* El sistema no permite datos vacíos
* Los equipos no pueden repetirse
* No se pueden registrar partidos con equipos inexistentes
* Los goles deben ser valores numéricos
* El sistema muestra mensajes claros ante errores

---

## Conclusión

El proyecto permitió aplicar conceptos fundamentales de Bash scripting como el uso de funciones, validaciones, manipulación de archivos y control de flujo.

Además, se reforzó la importancia de escribir código organizado y comprensible para su posterior defensa.

---
****
