#!/bin/bash
# Copyright(c) 2016-2100.  jielong.lin.  All rights reserved.
#
#   FileName:     _______vicc_auto_sync_by_GIT__in_crontab.sh
#   Author:       jielong.lin
#   Email:        493164984@qq.com
#   DateTime:     2017-05-11 14:34:27
#   ModifiedTime: 2017-08-16 09:56:16

_sshconf_name="qq1624646454@csdn_github"
_git_remote_url="https://github.com/qq1624646454/vicc/commits/master"

# _FN_retrieve_git_commits_by_GitURL \
#     "https://github.com/qq1624646454/jllutils/commits/master"
function _FN_retrieve_git_commits_by_GitURL()
{
    if [ x"$1" = x ]; then
        echo
        echo "JLL-return:: unknown Git URL parameter $1"
        echo
        return
    fi
    __HtmlFile=.git_commits.html
    # w3m https://github.com/qq1624646454/jllutils/commits/master > git_commits.html
    echo
    echo "JLL-network:: w3m $1"
    w3m $1 > ${__HtmlFile}
    echo
    echo "JLL-response:: parsing response for retrieving all git commits"
    echo
    __CTXLine="$(cat ${__HtmlFile} \
               | grep -n -A 1 -E '^[ \t]{0,}.*[ \t]{1,}committed[ \t]{1,}' --color=never)"
    rm -rf ${__HtmlFile} 2>/dev/null

    OldIFS="${IFS}"
    IFS=$'\n'
    for __CTXLn in ${__CTXLine}; do
        __CTXL=$(echo "${__CTXLn}" | grep -E '^[0-9]{1,}-[ \t]{1,}[0-9a-fA-F]{7,}')
        if [ x"${__CTXL}" != x ]; then
            __lstCommittedIDs[__iCommittedIDs++]="${__CTXL##* }"
        fi
    done
    IFS="${OldIFS}"

    for((__i=0;__i<__iCommittedIDs;__i++)) {
        echo "JLL-descend:: commit.id=${__lstCommittedIDs[__i]}"
    }

    [ x"${__CTXLine}" != x ] && unset __CTXLine
}

function _FN_is_align_with_git_remote()
{
    if [ x"${__iCommittedIDs}" != x -a ${__iCommittedIDs} -gt 0 ]; then
        __local_commitID=$(git log --oneline | head -n 1)
        __local_commitID="${__local_commitID%% *}"
        if [ x"${__local_commitID}" != x ]; then
            __isReturn=0
            echo "JLL-check:: local.lastest.commit.id --- remote.commit.id "
            for((__k=0;__k<__iCommittedIDs;__k++)) {
                echo "JLL-check:: ${__local_commitID} --- ${__lstCommittedIDs[__k]}"
                if [ x"${__local_commitID}" = x"${__lstCommittedIDs[__k]}" ]; then
                    __isReturn=1
                    echo "JLL-check:: HIT at ${__local_commitID} --- ${__lstCommittedIDs[__k]}"
                    break
                fi
            }
            if [ x"${__isReturn}" = x"1" -a x"$1" != x ]; then
                if [ x"${__local_commitID}" != x"${__lstCommittedIDs[0]}" ]; then
                    eval $1=1
                    return
                fi
                eval $1=0  # Has already aligned
                return
            fi
        fi
    fi
    if  [ x"$1" != x ]; then # other cases should be best to align.
        eval $1=1
    fi
}

function _FN_get_url_from_dotGIT()
{
    eval $1="none"
    if [ $# -ne 2 ]; then
        echo -e "JLL-Error:: not obey legal function prototype _FN_get_url_from_dotGIT"
        _FN_exit_with_free 0
    fi

    if [ -e "$2/.git/config" ]; then
        _url=$(sed -n '/\[remote "origin"\]/,/pushurl = /{p}' $2/.git/config)
        _url=$(echo "${_url}" | sed -n '/pushurl = /{p}')
        _url="${_url##*pushurl = }"
        if [ x"${_url}" = x ]; then
            _url=$(sed -n '/\[remote "origin"\]/,/url = /{p}' $2/.git/config)
            _url=$(echo "${_url}" | sed -n '/url = /{p}')
            _url="${_url##*url = }"
        fi
        if [ x"${_url}" != x ]; then
            eval $1="${_url}"
        fi
    fi
    [  x"${_url}" != x ] && unset _url
}



__ssh_package=.__ssh_R$(/bin/date +%Y_%m_%d__%H_%M_%S)
function __SSHCONF_Switching_Start()
{
    if [ x"$(ls ${JLLPATH}/sshconf/${_sshconf_name} 2>/dev/null)" = x ]; then
        /bin/echo "JLL: Error due to lack of \"${JLLPATH}/sshconf/${_sshconf_name}\""
        return
    fi
    /bin/echo
    if [ -e "${HOME}/.ssh" ]; then
        /bin/echo "JLL: Storing the original ssh configuration"
        /bin/echo "      ${HOME}/.ssh ===> ${HOME}/${__ssh_package}"
        /bin/mv -f ${HOME}/.ssh  ${HOME}/${__ssh_package}
        /bin/echo
    fi
    /bin/mkdir -p ${HOME}/.ssh
    /bin/chmod 0777 ${HOME}/.ssh
    /bin/cp -rf ${JLLPATH}/sshconf/${_sshconf_name}/*  ${HOME}/.ssh/
    /bin/chmod 0400 ${HOME}/.ssh/id_rsa
    [ -e "${HOME}/.ssh/known_hosts" ] && /bin/chmod 0644 ${HOME}/.ssh/known_hosts
    /bin/echo
}

function __SSHCONF_Switching_End()
{
    if [ -e "${HOME}/${__ssh_package}" ]; then
        if [ -e "${HOME}/.ssh" ]; then
            /bin/rm -rf ${HOME}/.ssh
        fi
        /bin/echo "JLL: Restoring the original ssh configuration"
        /bin/echo "      ${HOME}/.ssh <=== ${HOME}/${__ssh_package}"
        /bin/mv -f ${HOME}/${__ssh_package}  ${HOME}/.ssh
    else
        /bin/echo "JLL: Nothing to do for restoring the original ssh configuration."
    fi
}

function _FN_exit_with_free()
{
    [ x"${__iCommittedIDs}" != x ] && unset __iCommittedIDs
    [ x"${__lstCommittedIDs}" != x ] && unset __lstCommittedIDs
    [ x"${JLLPATH}" != x ] && unset JLLPATH 
    [ x"${JLLSELF}" != x ] && unset JLLSELF
    [ x"${__DT}" != x ] && unset __DT
    [ x"${__isAlign}" != x ] && unset __isAlign
    [ x"${__LOG}" != x ] && unset __LOG
    [ x"${__RemoteRepository}" != x ] && unset __RemoteRepository
    [ x"${__GitCHANGE}" != x ] && unset __GitCHANGE
    [ x"${__IsEnter}" != x ] && unset __IsEnter 

    [ x"$1" != x ] && exit $1 
}

function _FN_getSameLevelPath()
{
    if [ $# -ne 3 ]; then
        echo "JLL@_FN_getSameLevelPath| not obey specication of function prototype"
        _FN_exit_with_free 0 
    fi

    _locPath="$3"

    while [ x"${_locPath}" != x -a x"${_locPath}" != x"/" ]; do
        _locFileList=$(ls -a ${_locPath})
        for _locFile in ${_locFileList}; do
            if [ x"${_locFile}" = x"$2" ]; then
                eval $1="${_locPath}"
                _locPath=""
                break
            fi
        done
        if [ x"${_locPath}" != x -a y"${_locPath}" != y"/" ]; then
            _locPath=$(cd ${_locPath}/..;pwd)
        else
            break
        fi
    done

    [ x"${_locPath}" != x ] && unset _locPath
    [ x"${_locFile}" != x ] && unset _locFile
    [ x"${_locFileList}" != x ] && unset _locFileList
}


__DT=$(/bin/date +%Y-%m-%d_%H:%M:%S)
__LOG=${HOME}/cron.vicc@${__DT}.log
[ x"$(/bin/ls -l ${HOME}/cron*.log 2>/dev/null)" != x ] && rm -rf ${HOME}/cron*.log
JLLPATH=${HOME}/.vicc/vicc_for_linux64   # it will be set some value by another tool
if [ x"${JLLPATH}" = x -o ! -e "${JLLPATH}" ]; then
    /bin/echo "JLL: Error due to illegal settings, please set setJLLPATH____" >> ${__LOG}
    _FN_exit_with_free 0
fi
JLLSELF="$(/usr/bin/basename ${JLLPATH})"
__LOG=${HOME}/cron.${JLLSELF}@${__DT}.log
>${__LOG}
if [ x"${JLLSELF}" = x ]; then
    JLLSELF=$(/bin/pwd)
    JLLSELF="$(/usr/bin/basename ${JLLSELF})"
    [ x"${JLLSELF}" = x ] && JLLSELF="unknown"
fi

if [ ! -e "${JLLPATH}/.git" ]; then
    _FN_getSameLevelPath gitPath ".git" "${JLLPATH}"
    JLLPATH="${gitPath}"
    [ x"${gitPath}" != x ] && unset gitPath 
    if [ x"${JLLPATH}" = x -a ! -e "${JLLPATH}/.git" ]; then
        /bin/echo
        /bin/rm -rf ${HOME}/cron.*.log
        /bin/echo
        /bin/echo "JLL: Error because not present \"${JLLPATH}/.git\"" >> ${__LOG}
        /bin/echo "JLL: FOR ${JLLSELF}" >> ${__LOG}
        /bin/echo
        _FN_exit_with_free 0
    fi
fi

_FN_get_url_from_dotGIT __RemoteRepository "${JLLPATH}" 
[ x"${__RemoteRepository}" != x"none" ] \
    && __RemoteRepository=${__RemoteRepository#*:} || __RemoteRepository="remote.${JLLSELF}"
/bin/echo "synchronizing with ${__RemoteRepository} @${__DT}"  >>${__LOG}

cd ${JLLPATH}
__GitCHANGE="$(/usr/bin/git status -s)"
if [ x"${__GitCHANGE}" != x ]; then
    if [ x"$(ls ${JLLPATH}/sshconf/${_sshconf_name} 2>/dev/null)" = x ]; then
        /usr/bin/git clean -dfx 2>/dev/null; /usr/bin/git reset --hard HEAD 2>/dev/null >> ${__LOG}
    else
        /usr/bin/git status -s  >> ${__LOG}
        /usr/bin/git add -A     >> ${__LOG}
        /usr/bin/git commit -m "Submit changes by auto-synchronize tool @${__DT}" >> ${__LOG}
        /bin/echo                   >> ${__LOG}
        __SSHCONF_Switching_Start   >> ${__LOG}
        /bin/echo "Push Changes to '${__RemoteRepository}' by git push"  >> ${__LOG}
        /usr/bin/git push           >> ${__LOG} 
        __SSHCONF_Switching_End     >> ${__LOG}
        /usr/bin/git status -s      >> ${__LOG} 
        /usr/bin/git log -4         >> ${__LOG}
        /bin/echo                   >> ${__LOG}
    fi 
fi


declare -a __lstCommittedIDs
declare -i __iCommittedIDs=0
_FN_retrieve_git_commits_by_GitURL "${_git_remote_url}" >> ${__LOG} 
_FN_is_align_with_git_remote __isAlign  >> ${__LOG} 
[ x"${__lstCommittedIDs}" != x ] && unset __lstCommittedIDs
[ x"${__iCommittedIDs}" != x ] && unset __iCommittedIDs

/bin/echo >> ${__LOG} 
/bin/echo "Check if align with remote via __isAlign=${__isAlign}"    >> ${__LOG} 
if [ x"${__isAlign}" = x"1" ]; then
    /bin/echo "Pull Changes from '${__RemoteRepository}' by git pull "   >> ${__LOG} 
    /usr/bin/git pull -f -u origin master    >> ${__LOG} 
fi
/usr/bin/git log -4    >> ${__LOG} 
/bin/echo    >> ${__LOG} 
cd - >/dev/null

_FN_exit_with_free 0
