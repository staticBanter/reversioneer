#!/bin/bash

main(){

    optExec $@

    if [ ! $auto_action ]; then

        options="create read update"

        echo "Choose your option:"

        select option in $options
        do

            case $option in
                "create")
                    create_versionFile
                    ;;
                "read")
                    read_versionFile
                    ;;
                "update")
                    update_versionFile
                    ;;
                *)
                    echo "ERROR: Unsupported Option."
                    exit
                    ;;
            esac

        break;
        done

    else

        case $auto_action in
            "create")
                create_versionFile
                ;;
            "read")
                read_versionFile
                ;;
            "update")
                update_versionFile
                ;;
            *)
                echo "ERROR: Unsupported Option."
                exit
                ;;
        esac

    fi

}
