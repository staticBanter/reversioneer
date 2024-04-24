#!/bin/bash

function set_creationDate(){

    wasCreatedToday=""

    read -p "Was this Program Created Today? (Y/n)" wasCreatedToday

    if [[ "${wasCreatedToday}" == "N" || "${wasCreatedToday}" == "n" ]]; then

        read -p "Enter the Programs Creation Date in ISO-8601 Format (YYYY-MM-DD)" program_creationDate

    else

        program_creationDate=$(date --date='now' -I | tr -d "-")

    fi

}
