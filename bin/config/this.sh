#!/bin/bash

versionFile_name="VERSION"
versionFile_delimiter="|%|"
versionFile_type=""
versionFiles="package.json package-lock.json composer.json .ENV .env README.md readme.md README readme"

buildDataMarker="+"
environmentMarker="-"

versionNumber_default="0.1.0-development.0.0"
eMajor_default="development"
eMajorSub_default="alpha"

select_option=""

toggle_quiet=""
toggle_git=""
toggle_noReadMe=
toggle_noExternals=""

auto_action=""
auto_read=""
