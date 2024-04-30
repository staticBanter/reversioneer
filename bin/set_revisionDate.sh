#!/bin/bash

function set_revisionDate(){

    program_revisionDate="$(date --date='now' -I | tr -d "-")"

    return;

}
