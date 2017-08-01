#!/bin/bash
#copyright(c) 2017-2100.   jielong.lin@qq.com    All rights reserved.
#2017-07-30
#

_JLLCFG_rootPath=${HOME}/.vicc/vicc_for_linux64

### Usage:
#
# $0 install 
# $0 uninstall 
#

function FN_exit()
{
    [ x"${ESC}" != x ] && unset ESC 
    [ x"${AC}" != x ] && unset AC 
    [ x"${Fblack}" != x ] && unset Fblack
    [ x"${Fred}" != x ] && unset Fred 
    [ x"${Fgreen}" != x ] && unset Fgreen
    [ x"${Fyellow}" != x ] && unset Fyellow
    [ x"${Fblue}" != x ] && unset Fblue
    [ x"${Fpink}" != x ] && unset Fpink
    [ x"${Fseablue}" != x ] && unset Fseablue
    [ x"${Fwhite}" != x ] && unset Fwhite
    [ x"${Bblack}" != x ] && unset Bblack
    [ x"${Bred}" != x ] && unset Bred 
    [ x"${Bgreen}" != x ] && unset Bgreen
    [ x"${Byellow}" != x ] && unset Byellow
    [ x"${Bblue}" != x ] && unset Bblue
    [ x"${Bpink}" != x ] && unset Bpink
    [ x"${Bseablue}" != x ] && unset Bseablue
    [ x"${Bwhite}" != x ] && unset Bwhite

    [ x"${_JLLCFG_rootPath}" != x ] && unset _JLLCFG_rootPath
    [ x"${CvPathFileForScript}" != x ] && unset CvPathFileForScript

    exit 0
}

function FN_setup_vicc_executable_environment()
{
    if [ ! -e "${_JLLCFG_rootPath}/jllsystem" ]; then
        echo -e "JLL: Error due to lack of ${Fred}${_JLLCFG_rootPath}/jllsystem${AC}"
        FN_exit 0
    fi
    if [ ! -e "${_JLLCFG_rootPath}/vimrc" ]; then
        echo -e "JLL: Error due to lack of ${Fred}${_JLLCFG_rootPath}/vimrc${AC}"
        FN_exit 0
    fi
    if [ ! -e "${_JLLCFG_rootPath}/vimrcs" ]; then
        echo -e "JLL: Error due to lack of ${Fred}${_JLLCFG_rootPath}/vimrcs${AC}"
        FN_exit 0
    fi
    if [ ! -e "${_JLLCFG_rootPath}/vim" ]; then
        echo -e "JLL: Error due to lack of ${Fred}${_JLLCFG_rootPath}/vim${AC}"
        FN_exit 0
    fi

    if [ -e "${HOME}/.jllsystem" ]; then
        rm -rf ${HOME}/.jllsystem
    fi
    ln -sv ${_JLLCFG_rootPath}/jllsystem  ${HOME}/.jllsystem

    if [ -e "${HOME}/.vimrc" ]; then
        rm -rf ${HOME}/.vimrc
    fi
    ln -sv ${_JLLCFG_rootPath}/vimrc ${HOME}/.vimrc

    if [ -e "${HOME}/.vimrcs" ]; then
        rm -rf ${HOME}/.vimrcs
    fi
    ln -sv ${_JLLCFG_rootPath}/vimrcs ${HOME}/.vimrcs

    if [ -e "${HOME}/.vim" ]; then
        rm -rf ${HOME}/.vim
    fi
    ln -sv ${_JLLCFG_rootPath}/vim ${HOME}/.vim
}

function FN_remove_vicc_executable_environment()
{
    if [ -e "${HOME}/.jllsystem" ]; then
        rm -rf ${HOME}/.jllsystem
    fi

    if [ -e "${HOME}/.vimrc" ]; then
        rm -rf ${HOME}/.vimrc
    fi

    if [ -e "${HOME}/.vimrcs" ]; then
        rm -rf ${HOME}/.vimrcs
    fi

    if [ -e "${HOME}/.vim" ]; then
        rm -rf ${HOME}/.vim
    fi
}



CvPathFileForScript="`which $0`"
# ./xxx.sh
# ~/xxx.sh
# /home/xxx.sh
# xxx.sh
if [ x"${CvPathFileForScript}" != x ]; then
    CvScriptName=${CvPathFileForScript##*/}
    CvScriptPath=${CvPathFileForScript%/*}
    if [ x"${CvScriptPath}" = x ]; then
        CvScriptPath="$(pwd)"
    else
        CvScriptPath="$(cd ${CvScriptPath};pwd)"
    fi
    if [ x"${CvScriptName}" = x ]; then
        echo
        echo "JLL-Exit| Not recognize the command \"$0\", then exit - 0"
        echo
        [ x"${CvPathFileForScript}" != x ] && unset CvPathFileForScript
        [ x"${CvScriptName}" != x ] && unset CvScriptName
        [ x"${CvScriptPath}" != x ] && unset CvScriptPath
        exit 0
    fi
else
    echo
    echo "JLL-Exit| Not recognize the command \"$0\", then exit - 1"
    echo
    [ x"${CvPathFileForScript}" != x ] && unset CvPathFileForScript
    [ x"${CvScriptName}" != x ] && unset CvScriptName
    [ x"${CvScriptPath}" != x ] && unset CvScriptPath
    exit 0
fi

selfPath=${CvScriptPath}
selfName=${CvScriptName}
[ x"${CvPathFileForScript}" != x ] && unset CvPathFileForScript
[ x"${CvScriptName}" != x ] && unset CvScriptName
[ x"${CvScriptPath}" != x ] && unset CvScriptPath


# adapt to more/echo/less and so on
  ESC=
  AC=${ESC}[0m
  Fblack=${ESC}[30m
  Fred=${ESC}[31m
  Fgreen=${ESC}[32m
  Fyellow=${ESC}[33m
  Fblue=${ESC}[34m
  Fpink=${ESC}[35m
  Fseablue=${ESC}[36m
  Fwhite=${ESC}[37m
  Bblack=${ESC}[40m
  Bred=${ESC}[41m
  Bgreen=${ESC}[42m
  Byellow=${ESC}[43m
  Bblue=${ESC}[44m
  Bpink=${ESC}[45m
  Bseablue=${ESC}[46m
  Bwhite=${ESC}[47m

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
    fi
}

function FN_registe_into_bashrc()
{
    echo -e "${Bgreen}${Fblack}JLL: Starting FN_registe_into_bashrc${AC}"
    loc_Symbol="source \${HOME}/.jllsystem/settings/source_vicc_in_bashrc.sh"
    [ ${#loc_Symbol} -gt 50 ] && loc_Symbol_="${loc_Symbol:0:47}..." || loc_Symbol_="${loc_Symbol}"
    echo -e "JLL: Checking if ${Fgreen}${loc_Symbol_}${AC} is registed in ${HOME}/.bashrc"
    loc_LstrLines=""
    if [ -e "${HOME}/.bashrc" ]; then
        loc_LstrLines=$(grep -En "^[ \t]{0,}${loc_Symbol/$/[$]}" ${HOME}/.bashrc)
    fi
    if [ x"${loc_LstrLines}" = x ]; then
        #arrive here, not found "source ${HOME}/.jllsystem/settings/source_vicc_in_bashrc.sh" 
        echo -e "JLL: CHK result is ${Fred}${loc_Symbol_}${AC} is not registed"
        echo "${loc_Symbol}" >> ${HOME}/.bashrc
        echo -e "JLL: Registe ${Fseablue}${loc_Symbol_}${AC} into the END of ${HOME}/.bashrc"
    else
        #arrive here, found "source ${HOME}/.jllsystem/settings/source_vicc_in_bashrc.sh" 
        # Should check if autocomplete_vicc.sh is valid.
        echo -e "JLL: CHK result is ${Fgreen}${loc_Symbol_}${AC} is already been registed"
    fi
    echo -e "${Bgreen}${Fblack}JLL: Ending   FN_registe_into_bashrc${AC}"
    [ x"${loc_Symbol}" != x ] && unset loc_Symbol
    [ x"${loc_Symbol_}" != x ] && unset loc_Symbol_
    [ x"${loc_LstrLines}" != x ] && unset loc_LstrLines
}

function FN_unregiste_from_bashrc()
{
    echo -e "${Bgreen}${Fblack}JLL: Starting FN_unregiste_from_bashrc${AC}"
    loc_Symbol="source \${HOME}/.jllsystem/settings/source_vicc_in_bashrc.sh"
    [ ${#loc_Symbol} -gt 50 ] && loc_Symbol_="${loc_Symbol:0:47}..." || loc_Symbol_="${loc_Symbol}"
    echo -e "JLL: Checking if ${Fgreen}${loc_Symbol_}${AC} is registed in ${HOME}/.bashrc"
    loc_LstrLines=""
    if [ -e "${HOME}/.bashrc" ]; then
        loc_LstrLines=$(grep -En "^[ \t]{0,}${loc_Symbol/$/[$]}" ${HOME}/.bashrc)
    fi
    if [ x"${loc_LstrLines}" = x ]; then 
        #arrive here, not found "source ${HOME}/.jllsystem/settings/source_vicc_in_bashrc.sh" 
        echo -e "JLL: CHK result is ${Fseablue}${loc_Symbol_}${AC} is not found in ${HOME}/.bashrc"
    else
        #arrive here, found "source ${HOME}/.jllsystem/settings/source_vicc_in_bashrc.sh" 
        # Should check if autocomplete_vicc.sh is valid.
        echo -e "JLL: CHK result is ${Fgreen}${loc_Symbol_}${AC} is found in ${HOME}/.bashrc"
        OIFS=${IFS}
        IFS=$'\n'
        for loc_line in ${loc_LstrLines}; do
            echo "${loc_line%%:*}" | grep -E '[^0-9]' >/dev/null \
                 && loc_lineNo=0 || loc_lineNo=${loc_line%%:*}
            if [ x"${loc_lineNo}" = x"0" ]; then
                echo -e "JLL: Failed to obtain the line number from ${Fred}${loc_line}${AC}"
                continue
            fi
            sed "${loc_lineNo}"d -i ${HOME}/.bashrc
            echo -e "JLL: Removing ${Fgreen}${loc_Symbol_}${AC} from ${HOME}/.bashrc:${loc_lineNo}"
        done
        IFS=${OIFS}
        [ x"${loc_line}" != x ] && unset loc_line
        [ x"${OIFS}" != x ] && unset OIFS 
        [ x"${loc_lineNo}" != x ] && unset loc_lineNo
    fi
    echo -e "${Bgreen}${Fblack}JLL: Ending   FN_unregiste_from_bashrc${AC}"
    [ x"${loc_Symbol}" != x ] && unset loc_Symbol
    [ x"${loc_Symbol_}" != x ] && unset loc_Symbol_
    [ x"${loc_LstrLines}" != x ] && unset loc_LstrLines
}


function FN_setup_auto_synchronize_in_crontab()
{
    if [ -e "${HOME}/.jllsystem/settings/_______vicc_auto_sync_by_GIT__in_crontab.sh" ]; then
       
        crontab -l  > tsk.crontab  2>/dev/null
        __chk_if_exist=$(cat tsk.crontab \
            | grep -E "[$]{HOME}/.jllsystem/settings/_______vicc_auto_sync_by_GIT__in_crontab.sh")
        if [ x"${__chk_if_exist}" = x ]; then
            echo "# auto synchronize for vicc" >>tsk.crontab
            echo "# m  h  dom mon dow command" >>tsk.crontab
            echo "  0  0  *   *   *  " \
                 "\${HOME}/.jllsystem/settings/_______vicc_auto_sync_by_GIT__in_crontab.sh" \
                 >>tsk.crontab
            crontab tsk.crontab
        fi
        echo
        echo -e "JLL| set when to run _______vicc_auto_sync_by_GIT__in_crontab.sh in crontab"
        crontab -l
        echo
        [ -e "$(pwd)/tsk.crontab" ] && rm -rf tsk.crontab
    fi
}


function FN_remove_auto_synchronize_in_crontab()
{
    crontab -l  > tsk.crontab  2>/dev/null
    __chk_if_exist=$(cat tsk.crontab | grep -E "_______vicc_auto_sync_by_GIT__in_crontab.sh")
    if [ x"${__chk_if_exist}" != x ]; then
        sed '/# auto synchronize for vicc/,/_______vicc_auto_sync_by_GIT__in_crontab.sh/{d}' \
            -i tsk.crontab
        crontab tsk.crontab
        echo
        crontab -l
        echo
    fi
    [ -e "$(pwd)/tsk.crontab" ] && rm -rf tsk.crontab

    if [ -e "${HOME}/.jllsystem/settings/_______vicc_auto_sync_by_GIT__in_crontab.sh" ]; then
        rm -rvf ${HOME}/.jllsystem/settings/_______vicc_auto_sync_by_GIT__in_crontab.sh
    fi
}


if [ x"$1" != x ]; then
case $1 in
install)
    _cprefix="${Bgreen}  ${AC}"
    _cfg="${Fgreen}"
more >&1 <<EOF

${Bgreen}${Fblack}  ${selfName} install                             ${AC} 
${_cprefix} The below Functions will be installed:
${_cprefix} (1).To registe ${Fgreen}PATH=${HOME}/.jllsystem/bin:\${PATH}${AC} \
to ${Fgreen}${HOME}/.bashrc${AC}
${_cprefix} (2).To enable ${Fgreen}autocomplete for vicc command ${AC}
${Bgreen}${Fblack}                                                                      ${AC} 

EOF

    FN_setup_vicc_executable_environment

    [ ! -e "${HOME}/.jllsystem/settings" ] && \
        mkdir -pv ${HOME}/.jllsystem/settings

    if [ -e "${HOME}/.jllsystem/settings/source_vicc_in_bashrc.sh" ]; then 
        FN_registe_into_bashrc
    else
        echo -e \
        "JLL: Failure due to lack of \"${HOME}/.jllsystem/settings/source_vicc_in_bashrc.sh\""
    fi

    if [ -e "${HOME}/.jllsystem/settings/_______vicc_auto_sync_by_GIT__in_crontab.sh" ]; then
        FN_setup_auto_synchronize_in_crontab
    else
        echo -e "JLL: Failure due to lack of" \
        "\"${HOME}/.jllsystem/settings/_______vicc_auto_sync_by_GIT__in_crontab.sh\""
    fi

    [ x"${_cprefix}" != x ] && unset _cprefix
    [ x"${_cfg}" != x ] && unset _cfg
;;
uninstall)
    FN_remove_auto_synchronize_in_crontab
    FN_unregiste_from_bashrc
    FN_remove_vicc_executable_environment
;;
esac
fi

FN_exit

