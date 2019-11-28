#!/usr/bin/env bash

# python functions
function mkvirtualenv {
    if [ $# -eq 0 ]
    then
        dot_help mkvirtualenv
        return 1
    fi
    cd $VIRTUALENVS
    virtualenv -p python$2 $1
    usevirtualenv $1
    cdproj $1

}

complete -F _cdproj mkvirtualenv

_virtualenv()
    {
        if [ $COMP_CWORD -eq 1 ]; then     
            local cur=${COMP_WORDS[COMP_CWORD]}
            COMPREPLY=( $(compgen -W "$(ls $VIRTUALENVS)" -- $cur) )
        fi
    }

function rmvirtualenv {
    if [ $# -eq 1 ]
    then
        deactivate || true
        rm -rf $VIRTUALENVS/$1
        return 0
    fi
    dot_help rmvirtualenv

}
complete -F _virtualenv rmvirtualenv

function usevirtualenv {
    if [ $# -eq 1 ]
    then
        source $VIRTUALENVS/$1/bin/activate
        return 0
    fi

    dot_help usevirtualenv

}
complete -F _virtualenv usevirtualenv

function cdvirtualenv {
    if [ $# -eq 1 ] || [ $# -eq 2 ]
    then
        usevirtualenv $1
        if [ $# -eq 1 ]
        then
            cdproj $1
        elif [ $# -eq 2 ]
        then
            cdproj $2    
        fi
        return 0        
    fi
    dot_help cdvirtualenv
    
}
complete -F _virtualenv cdvirtualenv
