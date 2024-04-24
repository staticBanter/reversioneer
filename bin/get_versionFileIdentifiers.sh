#!/bin/bash

function get_revisionDate(){
    program_creationDate=$(sed '5q;d' "./${versionFile_name}")
}

function get_creationDate(){
    program_creationDate=$(sed '4q;d' "./${versionFile_name}")
}

function get_author(){
    program_author=$(sed '3q;d' "./${versionFile_name}")
}

function get_title(){
    program_title=$(sed '2q;d' "./${versionFile_name}")
}

function get_versionNumber(){
    program_version=$(sed '1q;d' "./${versionFile_name}")
}
