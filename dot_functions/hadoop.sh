#!/usr/bin/env bash

# hadoop functions
function change_hadoop {
    case "$1" in
        local)
            export HADOOP_CONF_DIR=$HADOOP_CONF_DIR_LOCAL
            ;;

        *)
            dot_help change_hadoop
 
    esac
}

_change_hadoop()
    {
        local cur=${COMP_WORDS[COMP_CWORD]}
        if [ $COMP_CWORD -eq 1 ]; then
            COMPREPLY=( $(compgen -W "local" -- $cur) )
        fi
    }
complete -F _change_hadoop change_hadoop


function copy_hadoop_deps {
    if [ $# -eq 0 ]
    then
        echo Need requirements libs
        return 1
    fi
    if [ $# -eq 1 ]
    then
        echo Need user for copy
        return 1
    fi
    if [ $# -eq 2 ]
    then
        echo "Need environment from (local, qa or prod) copy"
        return 1
    fi
    if [ $# -eq 3 ]
    then
        echo "Need environment to (local, qa or prod) copy"
        return 1
    fi
    replace='hdfs://'
    IFS=',' read -r -a array <<< "$1"
    for dep in "${array[@]}"; do
        depNoPrefix=${dep//$replace/}
        depFilename="${depNoPrefix##*/}"
        depDir=$(dirname "${depNoPrefix}")

        echo copying $dep to /tmp/$depFilename
        change_hadoop $3
        rm -f /tmp/$depFilename
        hdfs dfs -copyToLocal $dep /tmp/$depFilename

        echo copying /tmp/$depFilename to $depNoPrefix
        change_hadoop $4
        hdfs dfs -mkdir -p $depDir
        hdfs dfs -copyFromLocal -f /tmp/$depFilename $depNoPrefix
        hdfs dfs -chown -R $2 $depNoPrefix
    done
}

_copy_hadoop_deps()
    {
        local cur=${COMP_WORDS[COMP_CWORD]}
        if [ $COMP_CWORD -eq 3 ]; then
           COMPREPLY=( $(compgen -W "dev qa prod prod-hdp" -- $cur) )
        elif [ $COMP_CWORD -eq 4 ]; then
           COMPREPLY=( $(compgen -W "dev qa prod prod-hdp" -- $cur) )
        fi
    }
complete -F _copy_hadoop_deps copy_hadoop_deps
