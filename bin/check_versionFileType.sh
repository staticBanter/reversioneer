#!/bin/bash

function check_versionFileType(){

    versionFileLineCount="$(wc -l "./${versionFile_name}" | cut -d " " -f 1)"

    case $versionFileLineCount in
        "1")
            versionFile_type="numeric"
            ;;
        "2")
            versionFile_type="titled"
            ;;
        "3")
            versionFile_type="authored"
            ;;
        "4")
            versionFile_type="creation-date"
            ;;
        "5")
            versionFile_type="revision-date"
            ;;

        *)
            echo "ERROR: Unsupported Version File."
            exit;
            ;;
    esac;

    return;

}
