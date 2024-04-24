#!/bin/bash

function swapVersionNumbers(){

    case $1 in
        *".json"*)
            old_versionNumberString=$(grep -wi "\"version\":" "./$1" | tr -d ",")
            old_versionStringIdentifier=$(grep -wi "\"version\":" "./$1" | cut -d ":" -f1)
            sed -i s/"${old_versionNumberString}"/"${old_versionStringIdentifier}:\"${program_version}\""/ $1
        ;;
        *".ENV"* | *".env"*)
            old_versionNumberString=$(grep -wi "version" "./$1")
            old_versionStringIdentifier=$(grep -wi "version" "./$1" | cut -d "=" -f1)
            sed -i s/"${old_versionNumberString}"/"${old_versionStringIdentifier}=${program_version}"/ $1
        ;;
        "README.md" | "readme.md" | "README" | "readme")

            if [ ! $toggle_noReadMe ]; then

                old_versionNumberString=$(grep -wi "version:" "./$1" | head -1)
                old_versionStringIdentifier=$(grep -wi "version:" "./$1" | head -1 |cut -d " " -f1)
                sed -i "0,/${old_versionNumberString}/s//${old_versionStringIdentifier} ${program_version}/" $1

            fi

        ;;
    esac

    return;
}

function update_externalVersionFiles(){

    echo "Updating External Version Files..."

    for versionFile in $versionFiles; do

        if [ ! -e "./$versionFile" ]; then
            continue;
        fi

        swapVersionNumbers "${versionFile}"

        if [ $toggle_git ]; then

            git add "./${versionFile}"

        fi

    done;

}
