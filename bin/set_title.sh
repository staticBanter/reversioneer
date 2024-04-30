#!/bin/bash

function set_title(){

    program_title=$(basename "$PWD")

    correctProgramTitle=""

    echo "Estimated Program Title to be: $program_title."

    read -rp "Is this correct? (Y/n)" correctProgramTitle

    if [[ "${correctProgramTitle}" == "n" || "${correctProgramTitle}" == "N" ]]; then

        read -rp "Enter your Programs Title:" program_title

    fi

    return;

}
