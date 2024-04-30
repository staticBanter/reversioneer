#!/bin/bash

function update_versionFile(){

    if [[ ! -e "./$versionFile_name" && ! -e "VERSION" ]]; then

        createVersionFile=""

        echo "There was No Version File Detected."

        read -rp "Would you like to Create A Version File? (Y/n)" createVersionFile

        if [[ "${createVersionFile}" == "n" || "${createVersionFile}" == "N" ]]; then
            return;
        fi

        create_versionFile

        return;

    fi

    check_versionFileType

    versionFileString=""

    case $versionFile_type in
        "revision-date")
            set_revisionDate
            versionFileString=$'\n'"$program_revisionDate"
            ;&
        "creation-date")
            get_creationDate
            versionFileString=$'\n'"$program_creationDate$versionFileString"
            ;&
        "authored")
            get_author
            versionFileString=$'\n'"$program_author$versionFileString"
            ;&
        "titled")
            get_title
            versionFileString=$'\n'"$program_title$versionFileString"
            ;&
        "numeric")
            update_versionNumber
            versionFileString="$program_version$versionFileString"
            ;;
        *)
            echo "ERROR: Unsupported Version File Type."
            exit
            ;;
    esac

    echo "$versionFileString" > "./$versionFile_name"

    if [ $toggle_git ]; then

        git add "./${versionFile_name}"

    fi

    if [ ! $toggle_noExternals ]; then

        update_externalVersionFiles

    fi

}
