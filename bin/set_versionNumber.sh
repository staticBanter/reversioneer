#!/bin/bash

highestVersionNumber=""
highestVersionNumberFile=""

highestVersionNumber_major=""
highestVersionNumber_minor=""
highestVersionNumber_patch=""
highestVersionNumber_eMajor=""
highestVersionNumber_eMajorSub=""
highestVersionNumber_eMinor=""
highestVersionNumber_ePatch=""
highestVersionNumber_buildData=""

function updateHighs(){

    highestVersionNumber_major="$program_major"
    highestVersionNumber_minor="$program_minor"
    highestVersionNumber_patch="$program_patch"
    highestVersionNumber_eMajor="$program_eMajor"
    highestVersionNumber_eMajorSub="$program_eMajorSub"
    highestVersionNumber_eMinor="$program_eMinor"
    highestVersionNumber_ePatch="$program_ePatch"
    highestVersionNumber_buildData="$program_buildData"

    return;

}

function compareVersionNumbers(){


    if [[ ! "$highestVersionNumber_major" || "$program_major" -gt "$highestVersionNumber_major"  ]]; then

        highestVersionNumberFile="${1}"

        updateHighs

        return;

    elif [[ "$program_major" -eq "$highestVersionNumber_major" ]]; then

        if [[ ! "$highestVersionNumber_minor" || "$program_minor" -gt "$highestVersionNumber_minor" ]]; then

            highestVersionNumberFile="${1}"

            updateHighs

            return;

        elif [ "$program_minor" -eq "$highestVersionNumber_minor" ]; then

            if [[ ! "$highestVersionNumber_patch" || "$highestVersionNumber_patch" -lt "$program_patch" ]]; then

                highestVersionNumberFile="${1}"

                updateHighs

                return;

            fi

        fi

    fi

}

function extractFromFile(){

    case $1 in
        *".json"*)
            extracted=$(grep -wi "\"version\":" "./$1" | cut -d ":" -f 2 | tr -d '"' |  tr -d " " | tr -d ",")
        ;;
        *".ENV"* | *".env"*)
            extracted=$(grep -wi "version" "./$1" | cut -d "=" -f2 | tr -d '"')
        ;;
    esac

    echo "${extracted}"
    return;
}

function set_versionNumber(){

    for versionFile in $versionFiles; do

        if [ ! -e "./$versionFile" ]; then


            continue;
        fi

        program_version=$(extractFromFile "${versionFile}")

        splitVersionIdentifiers

        compareVersionNumbers "$versionFile"

        continue;

    done;

    program_version=$(extractFromFile "$highestVersionNumberFile")

    if [ ! "$program_version" ]; then

        echo "No Valid Version Number Found..."

        if [ $toggle_useFallbacks ]; then

            echo "Using Defaults..."

            program_version=$versionNumber_default

            return;
        fi

        read -rp "Enter Custom Program Version or leave blank for default ($versionNumber_default): " program_version

        if [ ! "$program_version" ]; then
            program_version=$versionNumber_default
        fi

    else

        echo "Using Found Readable Versioning Files!"

    fi

    return;

}
