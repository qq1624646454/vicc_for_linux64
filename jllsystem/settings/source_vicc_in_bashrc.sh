#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     source_vicc_in_bashrc.sh
#   Author:       root
#   Email:        493164984@qq.com
#
# Implements Features as follows:
#   (1) registe vicc executable path in system
#   (2) autocomplete for vicc command


#
# vicc -l          || vicc --list
# vicc -c          || vicc --create
# vicc -d          || vicc --delete
# vicc -t <Symbol> || vicc --tag <Symbol>
# vicc -u          || vicc --update
# vicc --auto
#
function _FN_autocomplete_callback_for_vicc()
{
    local cur="${COMP_WORDS[COMP_CWORD]}"
    local prev="${COMP_WORDS[COMP_CWORD-1]}"

    local __cmd_args=""
    # COMP_CWORD is the system variable, it implies the current command keyword index.
    #    0: the first word
    case ${COMP_CWORD} in
    1) # Command name has already been done, the first parameter can be started.
        if [ x"$(echo ${cur} | grep -E '^-')" != x ]; then
            __cmd_args="-l --list -c --create -d --delete -t --tag -u --update --auto"
        fi
        ;;
    *)
        ;;
    esac

    if [ x"${__cmd_args}" != x ]; then
        # load the first level parameters into auto-completed list
        COMPREPLY=( $(compgen -W "${__cmd_args}" -- ${cur}) )
    else
        COMPREPLY=( $(compgen -f ${cur}) )
    fi
}

function FN_setup_autocomplete_for_vicc()
{
    if [ x"$(which vicc)" != x ]; then
        complete -F _FN_autocomplete_callback_for_vicc -o filenames "vicc"
    else
        echo -e "[41m[33m JLL-Error|" \
        "not setup autocomplete for vicc due to unknown vicc                    [0m"
        echo -e "[41m[33m JLL-Error|" \
        "maybe check it from ${HOME}/.jllsystem/settings/source_vicc_in_bashrc.sh [0m"
    fi
}

PATH=${HOME}/.jllsystem/bin:${PATH}

FN_setup_autocomplete_for_vicc
if [ x"$(which vicc)" != x ]; then
    echo -e \
    "JLL|  you can have already used [36mvicc IDE environment0m by command [36mvicc[0m"
fi
