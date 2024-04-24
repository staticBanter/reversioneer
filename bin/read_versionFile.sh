#!/bin/bash

read_versionFile(){

    if [ ! -e "./${versionFile_name}" ]; then

        echo "ERROR: Can not find a readable version file."
        exit;

    fi

    if [ ! $auto_read ]; then

        echo "Choose Your Read Option: "

        readOptions="version title authoring-group creation-date revision-date all"

        select readOption in $readOptions
        do

            case $readOption in

                "revision-date")
                    get_revisionDate
                    echo "${program_revisionDate}"
                ;;

                "creation-date")
                    get_creationDate
                    echo "${program_creationDate}"
                ;;

                "authoring-group")
                    get_author
                    echo "${program_author}"
                ;;

                "title")
                    get_title
                    echo "${program_title}"
                ;;

                "version")
                    get_versionNumber
                    echo "${program_version}"
                ;;

                "all")
                    cat "./${versionFile_name}"
                ;;

            esac

        break;
        done

    else

        case $auto_read in

            "revision-date")
                get_revisionDate
                echo "${program_revisionDate}"
            ;;

            "creation-date")
                get_creationDate
                echo "${program_creationDate}"
            ;;

            "authoring-group")
                get_author
                echo "${program_author}"
            ;;

            "title")
                echo "${program_title}"
            ;;

            "version")
                get_versionNumber
                echo "${program_version}"
            ;;

            "all")
                echo $(cat "./${versionFile_name}" | tr '\n' " ")
            ;;

        esac

    fi

}
