#!/bin/bash
pathDefault="$HOME/.config/keepass_defaultPath.log"
pathDefaultBD="$HOME/.config/keepass_defaultPathBD.log"

getPath() {
    tail -n 1 "$pathDefault"
}

suggestion() {
    echo "$(getColor "MAGENTA")Para más ayuda ejecute script con el argumento --help$(getColor "RESET")"
}

createPath() {
    local message myFilePath
    if validatePath && [[ "$1" == "CREATE" ]]; then
        echo "$(getColor "AMARILLO")Ya existe una ruta raíz establecida.$(getColor "RESET")"
        return 1
    fi
    if [[ "$1" == "CREATE" ]]; then
        message="Ingrese la ruta por defecto para futuras comprobaciones: "
    else
        message="Ingrese la nueva ruta por defecto para futuras comprobaciones: "
    fi

    read -e -p "$message" myFilePath
    myFilePath=${myFilePath/#\~/$HOME}
    myFilePath=${myFilePath//\$HOME/$HOME}
    if [[ ! -d "$myFilePath" ]]; then
        echo "$(getColor "ROJO")La ruta no existe o no es un directorio.$(getColor "RESET")" >&2
        return 1
    fi
    echo "$myFilePath" >| "$pathDefault"
    saveDatabases
}

saveDatabases() {
    if validatePath; then
        basename -s .kdbx "$(getPath)"/*.kdbx >| "$pathDefaultBD"
        return 0
    else
        return 1
    fi
}

readPath() {
    if validatePath; then
        local myPath
        myPath=$(getPath)
        printf "$(getColor "AMARILLO")─[ %s ]────────────────────────────────$(getColor "RESET")\n" "$myPath"
    else
        echo "$(getColor "ROJO")Aún no ha establecido una ruta raíz.$(getColor "RESET")"
        suggestion
    fi
}

updatePath() {
    if validatePath; then
        local decision
        while true; do
            read -p "$(getColor "AMARILLO")¿Desea actualizar la ruta raíz[SI/NO]:$(getColor "RESET") " decision
            if [[ "$decision" =~ ^[sS][iíÍ] ]]; then
                createPath "UPDATE"
                break
            elif [[ "$decision" =~ ^[nN][oO] ]]; then
                echo "$(getColor "MAGENTA")Se cancelo la petición$(getColor "RESET") $(getColor "ROJO")X$(getColor "RESET")"
                break 
            else
                echo "$(getColor "MAGENTA")Opción incorrecta, ingrese una opción valida.$(getColor "RESET") $(getColor "ROJO")X$(getColor "RESET")"
            fi
        done
    else
        echo "$(getColor "ROJO")No existe ruta raíz para poder editar, establesca una."
        suggestion
    fi
}

deletePath() {
    if validatePath; then
        local desicion
        while true; do
            read -p "Desea eliminar la ruta raíz[SI/NO]: " decision
            if [[ $decision =~ ^[sS][iíÍ]$ ]]; then
                rm -rf "$pathDefault"
                rm -rf "$pathDefaultBD"
                cat <<EOF
$(getColor "AMARILLO")          ╔══════════════════════════════════════════════════════════╗$(getColor "RESET")
$(getColor "AMARILLO")          ║$(getColor "RESET")       $(getColor "VERDE")Se borro con éxito la ruta raíz por defecto$(getColor "RESET")        $(getColor "AMARILLO")║$(getColor "RESET")
$(getColor "AMARILLO")          ╚══════════════════════════════════════════════════════════╝$(getColor "RESET")
EOF
                break 
            elif [[ "$decision" =~ ^[nN][oO]$ ]]; then
                echo "$(getColor "MAGENTA")Operación cancelada$(getColor "RESET")$(getColor "ROJO") X$(getColor "RESET")"
                break
            else
                echo "$(getColor "MAGENTA")No es una opción válida, ingrese un valor valido."$(getColor "RESET")$(getColor "ROJO") X$(getColor "RESET")
            fi
        done
    else
        echo "$(getColor "ROJO")No se puede ejecutar la eliminación porque no existe ruta raíz.$(getColor "RESET")"
        suggestion
    fi
}

validatePath() {
    [[ -f "$pathDefault" ]]
}

getBD() {
    declare -A databases

    local count
    count=1
    while read -r nameBD; do
        [[ -z "$nameBD" ]] && continue
        if [[ $1 == "view" ]]; then
            databases["--k$count"]="La comparación se hace con el archivo $nameBD"
        else
            databases["--k$count"]="$nameBD.kdbx"
        fi
        ((count++))
    done < "$pathDefaultBD"

    if [[ $1 == "view" ]]; then
        for database in $(printf "%s\n" "${!databases[@]}" | sort -V); do
            echo -e "$database\t\t${databases[$database]}"
        done
    else
        echo "${databases[$2]}"       
    fi
}

getHashCode() {
    local hashCode
    local database
    local filePathDefault
    database=$(getBD "database" "$1")
    filePathDefault=$(getPath)
    hashCode=$(sha512sum "$filePathDefault/$database" | awk '{print $1}')
    echo $hashCode
}

getColor() {

    declare -A colors

    colors["NEGRO"]="\033[0;30m"
    colors["ROJO"]="\033[0;31m"
    colors["VERDE"]="\033[0;32m"
    colors["AMARILLO"]="\033[0;33m"
    colors["AZUL"]="\033[0;34m"
    colors["MAGENTA"]="\033[0;35m"
    colors["CIAN"]="\033[0;36m"
    colors["BLANCO"]="\033[0;37m"

    colors["RESET"]="\033[0m"

    printf '%b' "${colors[$1]}"
}

help() {
    echo "$(getColor "MAGENTA")"
    if saveDatabases; then
        getBD "view"
    fi
    echo -e "--C\t\tEstablecer la ruta raíz que se utilizara para las comparaciones"
    echo -e "--R\t\tMostrar la ruta de la raíz"
    echo -e "--U\t\tEditar la ruta raíz"
    echo -e "--D\t\tEliminar la ruta raíz"
    echo "$(getColor "RESET")"
}

cat <<EOF
$(getColor "VERDE")         ╭──────────────────────────────────────────────────────────╮
         │                    Comparador de Hash                    │
         ╰──────────────────────────────────────────────────────────╯$(getColor "RESET")
EOF
if [[ $1 == '--help' ]]; then
    help
elif [[ $1 =~ ^--k[0-9]+$ ]]; then
    if validatePath ; then
        rootHashCode=$(getHashCode $1)
        read -e -p "Ingrese hash a comparar: " fileComparate
        filePath=$(readlink -f "$fileComparate" 2>/dev/null)
        if [[ -f "$filePath" ]]; then
            hashCode="$(sha512sum "$filePath" | awk '{print $1}')"
            if [[ $hashCode == $rootHashCode ]]; then
                echo "$(getColor "AMARILLO")             ┌                                                     ┐$(getColor "RESET")"
                echo "$(getColor "AMARILLO")             │$(getColor "RESET") $(getColor "CIAN")Verificación exitosa: Los archivos son idénticos$(getColor "RESET") $(getColor "VERDE")OK$(getColor "RESET") $(getColor "AMARILLO")│$(getColor "RESET")"
                echo "$(getColor "AMARILLO")             └                                                     ┘$(getColor "RESET")"

            else
                echo "$(getColor "AMARILLO")              ┌                                                   ┐$(getColor "RESET")"
                echo "$(getColor "AMARILLO")              │$(getColor "RESET") $(getColor "MAGENTA")Verificación fallida: Los archivos no coinciden$(getColor "RESET") $(getColor "ROJO")X$(getColor "RESET") $(getColor  "AMARILLO")│$(getColor "RESET")"
                echo "$(getColor "AMARILLO")              └                                                   ┘$(getColor "RESET")"
            fi
        else
            echo "No existe el fichero  $(basename "$fileComparate") para la comparación de hash"
            echo "$(getColor "AMARILLO") ─[$(getColor "RESET") $(getColor "MAGENTA")Fallo de verificación: El archivo base '$(basename "$fileComparate")' no existe en la ruta especificada$(getColor "RESET") $(getColor "ROJO")X$(getColor "RESET")$(getColor "AMARILLO") ]─────$(getColor "RESET")"
        fi
    else
        echo "Aún no ha establecido la ruta raíz donde se encuentra los hashes a comparar."
        suggestion
    fi

elif [[ $1 == "--C" ]]; then
    createPath "CREATE"
elif [[ $1 == "--R" ]]; then
    readPath
elif [[ $1 == "--U" ]]; then
    updatePath
elif [[ $1 == "--D" ]]; then
    deletePath

else
    echo "$(getColor "AMARILLO")ERROR: Debe ingresar un parámetro válido.$(getColor "RESET")"
    suggestion
fi
