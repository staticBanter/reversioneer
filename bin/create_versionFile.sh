#!/bin/bash

function create_versionFile(){

    targetDir="."

    if [ $1 ]; then

        check_nonRootDir "$1"

        targetDir="$1"

    fi

    if [ -e "$targetDir/$versionFile_name" ]; then

        createNewVersionFile=""

        echo "A Version File is already present."

        read -rp "Create a New Version File? (Y/n) " createNewVersionFile

        if [[ "${createNewVersionFile}" == "n" || "${createNewVersionFile}" == "N" ]]; then

            return;

        fi

        rm "$targetDir/$versionFile_name"

    fi

    versionFile_types="numeric titled authored creation-date revision-date"

    new_versionFileString=""

    if [ ! $2 ]; then

        echo "Select the Type of Version File you would like to create."

        select versionFile_type in $versionFile_types;
        do
            case $versionFile_type in
                "revision-date")
                    set_revisionDate
                    new_versionFileString=$'\n'"$program_revisionDate"
                    ;&
                "creation-date")
                    set_creationDate
                    new_versionFileString=$'\n'"$program_creationDate$new_versionFileString"
                    ;&
                "authored")
                    set_author
                    new_versionFileString=$'\n'"$program_author$new_versionFileString"
                    ;&
                "titled")
                    set_title
                    new_versionFileString=$'\n'"$program_title$new_versionFileString"
                    ;&
                "numeric")
                    set_versionNumber
                    new_versionFileString="$program_version$new_versionFileString"
                    ;;
                *)
                    echo "ERROR: Unsupported Version File Type."
                    exit
                    ;;
            esac
            break;
        done

    else

        case $2 in
            "revision-date")
                set_revisionDate
                new_versionFileString=$'\n'"$program_revisionDate"
                ;&
            "creation-date")
                set_creationDate
                new_versionFileString=$'\n'"$program_creationDate$new_versionFileString"
                ;&
            "authored")
                set_author
                new_versionFileString=$'\n'"$program_author$new_versionFileString"
                ;&
            "titled")
                set_title
                new_versionFileString=$'\n'"$program_title$new_versionFileString"
                ;&
            "numeric")
                set_versionNumber
                new_versionFileString="$program_version$new_versionFileString"
                ;;
            *)
                echo "ERROR: Unsupported Version File Type."
                exit
                ;;
        esac

        fi

    echo "$new_versionFileString" > "$targetDir/$versionFile_name"

    if [ "$toggle_git" ]; then

        git add "$targetDir/${versionFile_name}"

    fi

}
