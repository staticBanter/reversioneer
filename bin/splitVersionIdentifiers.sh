#!/bin/bash

function splitVersionIdentifiers(){

    buildDataMarkerLookup=${program_version#*$buildDataMarker}
    environmentMarkerLookup=${program_version#*$environmentMarker}

    buildDataMarkerPosition=$((${#program_version} - ${#buildDataMarkerLookup} - ${#buildDataMarker}))
    environmentDataMarkerPosition=$((${#program_version} - ${#environmentMarkerLookup} - ${#environmentMarker}))

    program_major=$(echo "${program_version}" | cut -d "." -f 1)
    program_minor=$(echo "${program_version}" | cut -d "." -f 2)

    if [[ $program_version == *"-"* || $program_version == *"+"* ]]; then

        if [[ $program_version == *"-"* && $program_version == *"+"* ]]; then

            if (( $buildDataMarkerPosition < $environmentDataMarkerPosition )); then

                program_patch=$(echo "${program_version}" | cut -d "." -f 3 | cut -d "+" -f 1)

                program_buildData=$(echo "${program_version}" | cut -d "+" -f 2 )

            else

                program_patch=$(echo "${program_version}" | cut -d "." -f 3 | cut -d "-" -f 1)

                program_eMajor=$(echo "${program_version}" | cut -d "." -f 3 | cut -d "-" -f 2)
                program_eMajorSub=$(echo "${program_version}" | cut -d "." -f 3 | cut -d "-" -f 3)
                program_eMinor=$(echo "${program_version}" | cut -d "." -f 4)
                program_ePatch=$(echo "${program_version}" | cut -d "." -f 5 | cut -d "+" -f 1)

                program_buildData=$(echo "${program_version}" | cut -d "+" -f 2 )

            fi

        elif [[ $program_version == *"-"* ]]; then

            program_patch=$(echo "${program_version}" | cut -d "." -f 3 | cut -d "-" -f 1)

            program_eMajor=$(echo "${program_version}" | cut -d "." -f 3 | cut -d "-" -f 2)
            program_eMajorSub=$(echo "${program_version}" | cut -d "." -f 3 | cut -d "-" -f 3)
            program_eMinor=$(echo "${program_version}" | cut -d "." -f 4)
            program_ePatch=$(echo "${program_version}" | cut -d "." -f 5)


        else

            programPatch=$(echo "${program_version}" | cut -d "." -f 3 | cut -d "+" -f 1)

            program_buildData=$(echo "${program_version}" | cut -d "+" -f 2 )

        fi

    else

        program_patch=$(echo "${program_version}" | cut -d "." -f 3)

    fi

}
