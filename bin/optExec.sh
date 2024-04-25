#!/bin/bash

function optExec(){

    for arg in "$@"; do

        shift

        case "$arg" in

            '--help')
                set -- "$@" '-h'
            ;;

            '--no-readMe')
                set -- "$@" '-R'
            ;;

            '--no-externals')
                set -- "$@" 'E'
            ;;

            '--action')
                set -- "$@" 'a'
            ;;

            *)
                set -- "$@" "$arg"
            ;;
        esac

    done

    while getopts ":hga:RE" opt
    do
        case "$opt" in
            'h')
                help
                exit;
            ;;
            'g')

                toggle_git=true

                if sh -c ": >/dev/tty" >/dev/null 2>/dev/null; then
                    exec < /dev/tty
                fi

            ;;
            'a')
                auto_action="$2"
                case $2 in
                    "read")
                        auto_read="$3"
                    ;;
                esac
            ;;
            'R')
                toggle_noReadMe=true
            ;;
            'E')
                toggle_noExternals=true
            ;;
            '*')
                echo "ERROR: Unsupported Option."
            ;;
        esac
    done

}
