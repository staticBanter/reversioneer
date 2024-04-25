#!/bin/bash

################################################################################
# Reversioneer | Jordan Vezina(staticBanter) | February 17th 2024 - PRESENT
################################################################################

# Don't allow running as root
if [ "$(id -u)" == "0" ]; then
	echo "ERROR: Cannot run as root user!"
	exit 1;
fi

this_script_path=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)

function check_nonRootDir(){

    if [ "$1" == "" ]; then

        echo 'ERROR: Could not locate the path for this script...'
        exit 1;

    elif [ "$1" == "/" ]; then

        continueWithRootDirectoryPath=""

        echo "WARNING: This scripts path is pointing to the ROOT (/) directory. This could be dangerous!"

        read -p "Would you like to continue? (y/N)" continueWithRootDirectoryPath

        if [[ "${continueWithRootDirectoryPath}" != "y" || "${continueWithRootDirectoryPath}" != "Y" ]]; then

            echo "Cancelling..."
            exit 1;

        fi

    fi

}

check_nonRootDir $this_script_path

this_bin_path="$this_script_path/bin"
this_config_path="$this_bin_path/config"

source "$this_config_path/this.sh"
source "$this_config_path/client.sh"
source "$this_bin_path/set_revisionDate.sh"
source "$this_bin_path/set_creationDate.sh"
source "$this_bin_path/set_author.sh"
source "$this_bin_path/set_title.sh"
source "$this_bin_path/set_versionNumber.sh"
source "$this_bin_path/get_versionFileIdentifiers.sh"
source "$this_bin_path/check_versionFileType.sh"
source "$this_bin_path/splitVersionIdentifiers.sh"
source "$this_bin_path/update_versionNumber.sh"
source "$this_bin_path/create_versionFile.sh"
source "$this_bin_path/read_versionFile.sh"
source "$this_bin_path/update_externalVersionFiles.sh"
source "$this_bin_path/update_versionFile.sh"
source "$this_bin_path/help.sh"
source "$this_bin_path/optExec.sh"
source "$this_bin_path/main.sh"

main "$@"

exit;
