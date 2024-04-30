#!/bin/bash

function set_author(){

    program_author=$(whoami)

    correct_program_author=""

    echo "Estimated Author or Working Group Name: $program_author."

    read -rp "Is this correct? (Y/n)" correct_program_author

    if [[ "${correct_program_author}" == "N" || "${correct_program_author}" == "n" ]]; then

        read -rp "Enter the Author or Working Group Name:" program_author

    fi

    return;

}
