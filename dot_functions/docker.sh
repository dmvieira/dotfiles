#!/usr/bin/env bash

function drun {
    if [ $# -eq 2 ]
    then
        docker run -i -t --rm -v "$(pwd)":/app -w /app $1 sh -c "$2"
        return 0
    fi
    dot_help drun  
}

_drun()
    {
        if [ $COMP_CWORD -eq 1 ]
        then
            local cur=${COMP_WORDS[COMP_CWORD]}
            COMPREPLY=( $(compgen -W "$(docker images --format "{{.Repository}}" | uniq | grep -v "<none>")" -- $cur) )            
        fi
    }


complete -F _drun drun