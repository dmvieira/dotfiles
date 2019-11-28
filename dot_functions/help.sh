#!/usr/bin/env bash

shopt -s extglob 

DOT_FUNCTIONS="change_hadoop copy_hadoop_deps mkproj cdproj rmproj mkvirtualenv rmvirtualenv usevirtualenv cdvirtualenv kafka_service mysql_service redis_service elasticsearch_service mongo_service zookeeper_service drun drun_java8"

function dot_help {

    h_change_hadoop() {
        echo $"""
        #########################################################
        change_hadoop:

            Change hadoop configuration files for environments.
            Usage: change_hadoop (local)
        
        #########################################################
        """
    }
    h_copy_hadoop_deps() {
        echo $"""
        #########################################################
        copy_hadoop_deps:

            Copy dependencies from hadoop to another.
            Usage: copy_hadoop_deps hdfs:///dep1.jar,hdfs:///dep2.jar user (prod|qa|local) (prod|qa|local)
        
        Copy deps from hadoop environment to another using some user
        #########################################################
        """
    }
    h_cdproj(){
        echo $"""
        #########################################################
        cdproj:

            Go to project path or workspace path if no args.
            Usage: cdproj {project_name}
        #########################################################
        """
    }
    h_mkproj(){
        echo $"""
        #########################################################
        mkproj:

            make project path on workspace using a git repo.
            Usage: mkproj project_git_repo {project_name}
        #########################################################
        """
    }
    h_rmproj(){
        echo $"""
        #########################################################
        rmproj:

            remove project path on workspace.
            Usage: rmproj project_name
        #########################################################
        """
    }
    h_mkvirtualenv(){
        echo $"""
        #########################################################
        mkvirtualenv:

            Make virtualenv with name and python version. Default with no version (system python).
            Usage: mkvirtualenv project_name {2.7|3.3}
        #########################################################
        """
    }
    h_rmvirtualenv(){
        echo $"""
        #########################################################
        rmvirtualenv:

            Remove virtualenv with name.
            Usage: rmvirtualenv project_name
        #########################################################
        """
    }
    h_usevirtualenv(){
        echo $"""
        #########################################################
        usevirtualenv:

            Use virtualenv with name.
            Usage: usevirtualenv project_name
        #########################################################
        """
    }
    h_cdvirtualenv(){
        echo $"""
        #########################################################
        cdvirtualenv:

            Use virtualenv and change to project with name or directory with same name as virtualenv.
            Usage: cdvirtualenv virtualenv_name {project_name}
        #########################################################
        """
    }
    h_kafka_service(){
        echo $"""
        #########################################################
        kafka_service:

            Run kafka with zookeeper docker compose.
            Usage: kafka_service (start|stop|restart)
        #########################################################
        """
    }
    h_mysql_service(){
        echo $"""
        #########################################################
        mysql_service:

            Run mysql docker.
            Usage: mysql_service (start|stop|restart)
        #########################################################
        """
    }
    h_redis_service(){
        echo $"""
        #########################################################
        redis_service:

            Run redis docker.
            Usage: redis_service (start|stop|restart)
        #########################################################
        """
    }
    h_zookeeper_service(){
        echo $"""
        #########################################################
        zookeeper_service:

            Run zookeeper docker.
            Usage: zookeeper_service (start|stop|restart)
        #########################################################
        """
    }
    h_mongo_service(){
        echo $"""
        #########################################################
        mongo_service:

            Run mongodb docker.
            Usage: mongo_service (start|stop|restart)
        #########################################################
        """
    }
    h_elasticsearch_service(){
        echo $"""
        #########################################################
        elasticsearch_service:

            Run elasticsearch docker.
            Usage: elasticsearch_service (start|stop|restart)
        #########################################################
        """
    }
    h_drun(){
        echo $"""
        #########################################################
        drun:

            Run command on docker with any image.
            Usage: drun cogniteev/oracle-java:java8 \"df -h\"
        #########################################################
        """
    }
    h_drun_java8(){
        echo $"""
        #########################################################
        drun_java8:

            Run command on docker with java 8 image cogniteev/oracle-java:java8.
            Usage: drun_java8 df -h
        #########################################################
        """
    }
    local case_functions=$(echo '+('$(echo $DOT_FUNCTIONS | sed -e 's/ /|/g')')')
    case "$1" in
        $case_functions)
            eval "h_"$1
            ;;                                  
        *)

            IFS=' ' read -r -a array <<< "$DOT_FUNCTIONS"
            for func in "${array[@]}"; do
                eval "h_"$func
            done
    esac    
}
_dot_help()
    {        
        if [ $COMP_CWORD -eq 1 ]; then
            local cur=${COMP_WORDS[COMP_CWORD]}
            COMPREPLY=( $(compgen -W "$DOT_FUNCTIONS" -- $cur) )
        fi
    }
complete -F _dot_help dot_help
