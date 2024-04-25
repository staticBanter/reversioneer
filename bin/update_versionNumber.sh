#!/bin/bash

function checkEMajorVersionNumber(){

    if [ ! $program_eMajor ]; then

        echo "There was no initial Major Environment Version"

        read -p "Enter an Environment Version or leave blank for default (default: $eMajor_default):" program_eMajor

        if [ ! $program_eMajor ]; then
            program_eMajor="${eMajor_default}"
        fi

        if [ ! $program_eMajorSub ]; then

            echo "No Major Sub Environment Version Detected."

            addMajorSub=""

            read -p "Would you like to add a Major Sub Environment Version Identifier (y/N): " addMajorSub

            if [[ "${addMajorSub}" == "y" || "${addMajorSub}" == "y" ]]; then

                read -p "Enter the programs current Major Sub Environment or leave blank for default (default: $eMajorSub_default):" program_eMajorSub

                if [ ! $program_eMajorSub ]; then
                    program_eMajorSub="${eMajorSub_default}"
                fi

            fi

        fi

    fi

}

function update_versionNumber(){

    get_versionNumber

    splitVersionIdentifiers

    old_versionNumber=$program_version

    versionNumberUpdates="major minor patch e-major e-major-sub e-minor e-patch none"

    echo "Choose your Version Change."

    select versionNumberUpdate in $versionNumberUpdates
    do
        case $versionNumberUpdate in

            "major")

                (( program_major++ ))

                program_minor=0
                program_patch=0

                program_eMinor=0
                program_ePatch=0

            ;;

            "minor")

                (( program_minor++ ))

                program_patch=0

                program_eMinor=0
                program_ePatch=0

            ;;

            "patch")

                (( program_patch++ ))

                program_eMinor=0
                program_ePatch=0

            ;;

            "e-major")

                if [ ! $program_eMajor ]; then

                    echo "No Major Environment Version Detected."

                    read -p "Enter the programs current Major Environment or leave blank for default (default: $eMajor_default):" program_eMajor

                    if [ ! $program_eMajor ]; then
                        program_eMajor="${eMajor_default}"
                    fi

                else

                    echo "Current Major Environment: $program_eMajor"
                    echo "Enter A Custom Or Increment Major Environment Version Number"

                    select eMajorModification in custom increment
                    do

                        if [ "${eMajorModification}" == "increment" ]; then
                            (( program_eMajor++ ))
                        else
                            read -p "Enter the new Major Environment:" program_eMajor
                        fi

                        break;
                    done;

                fi

                addOrUpdateEMajorSub=""

                if [ $program_eMajorSub ]; then

                    echo "Current Major Sub Environment: $program_eMajorSub"

                else

                    echo "No Major Sub Environment Detected."

                fi

                read -p "Would you like to also update the Major Sub Environment? (y/N)" addOrUpdateEMajorSub

                if [[ "${addOrUpdateEMajorSub}" == "y" || "${addOrUpdateEMajorSub}" == "Y" ]]; then

                    if [ ! $program_eMajorSub ]; then

                        read -p "Enter the new Major Sub Environment or leave blank for default (default: $eMajorSub_default):" program_eMajorSub

                        if [ ! $program_eMajorSub ]; then
                            program_eMajorSub="${eMajorSub_default}"

                        fi

                    else

                        echo "Enter A Custom Or Increment Major Sub Environment Version Number"

                        select eMajorSubModification in custom increment
                        do

                            if [ "${eMajorSubModification}" == "increment" ]; then
                                (( program_eMajorSub++ ))
                            else
                                read -p "Enter the new Major Sub Environment:" program_eMajorSub
                            fi

                            break;
                        done;

                    fi

                fi

                program_eMinor=0
                program_ePatch=0

            ;;

            "e-major-sub")

                if [ ! $program_eMajor ]; then

                    echo "There was no initial Major Environment Version"

                    read -p "Enter an Environment Version or leave blank for default (default: $eMajor_default):" program_eMajor

                    if [ ! $program_eMajor ]; then
                        program_eMajor="${eMajor_default}"
                    fi

                fi

                if [ ! $program_eMajorSub ]; then

                    echo "No Major Sub Environment Version Detected."

                    read -p "Enter the programs current Major Sub Environment or leave blank for default (default: $eMajorSub_default):" program_eMajorSub

                    if [ ! $program_eMajorSub ]; then
                        program_eMajorSub="${eMajorSub_default}"
                    fi

                else

                    echo "Current Major Sub Environment: $program_eMajorSub"

                    select eMajorSubModification in custom increment
                    do
                        if [ "${eMajorSubModification}" == "increment"]; then
                            (( program_eMajorSub++ ))
                        else
                            read -p "Enter the new Major Sub Environment:" program_eMajorSub
                        fi

                        break;
                    done;

                fi

                program_eMinor=0
                program_ePatch=0

            ;;

            "e-minor")

                checkEMajorVersionNumber

                if [ $program_eMinor ]; then

                    (( program_eMinor++ ))

                else

                    program_eMinor=0

                fi

                program_ePatch=0

            ;;

            "e-patch")

                checkEMajorVersionNumber

                if [ $program_ePatch ]; then

                    (( program_ePatch++ ))

                else

                    program_ePatch=0

                fi

            ;;

            "none")
                exit;
            ;;

        esac

        break;
    done;

    program_version="$program_major.$program_minor.$program_patch"

    if [ $program_eMajor ]; then

        if [ $program_eMajorSub ]; then

            program_version="$program_version-$program_eMajor-$program_eMajorSub.$program_eMinor.$program_ePatch"

        else

            program_version="$program_version-$program_eMajor.$program_eMinor.$program_ePatch"

        fi

    fi

    if [ $program_buildData ]; then

        program_version="$program_version+$program_buildData"

    fi

}
