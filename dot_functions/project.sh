#!/usr/bin/env bash

# in project functions
function mkproj {
    if [ $# -eq 1 ]
    then
        cd $WORKSPACE
        git clone $1 $2
        if [ $# -eq 2 ]
        then
            cd $2
        else
            local withgit=${1/*\//}
            cd ${withgit/.git/}
        fi
        return 0
    fi
    dot_help mkproj
}
function cdproj {

    cd "$WORKSPACE/$1"
}

function rmproj {
    if [ $# -eq 1 ]
    then
        cdproj
        rm -rf "$WORKSPACE/$1"
        return 0
    fi
    dot_help rmproj    
    
}

_cdproj()
    {
        if [ $COMP_CWORD -eq 1 ]; then
            local cur=${COMP_WORDS[COMP_CWORD]}
            COMPREPLY=( $(compgen -W "$(ls $WORKSPACE)" -- $cur) )            
        fi
    }


complete -F _cdproj cdproj

complete -F _cdproj rmproj
