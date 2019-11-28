# DotFiles
My Dotfiles ;)

## Install

```
    ./install all
```

or install just a subset:

```
    ./install hadoop
    ./install spark    
```

type for help

```
    ./install
```

## Update

Same as install

## Using

### Show Commands help

```
    dot_help
```

### Functions


        #########################################################
        change_hadoop:

            Change hadoop configuration files for environments.
            Usage: change_hadoop (local)
        
        #########################################################
        

        #########################################################
        copy_hadoop_deps:

            Copy dependencies from hadoop to another.
            Usage: copy_hadoop_deps hdfs:///dep1.jar,hdfs:///dep2.jar user (prod|qa|local) (prod|qa|local)
        
        Copy deps from hadoop environment to another using some user
        #########################################################
        

        #########################################################
        mkproj:

            make project path on workspace using a git repo.
            Usage: mkproj project_git_repo {project_name}
        #########################################################
        

        #########################################################
        cdproj:

            Go to project path or workspace path if no args.
            Usage: cdproj {project_name}
        #########################################################
        

        #########################################################
        rmproj:

            remove project path on workspace.
            Usage: rmproj project_name
        #########################################################
        

        #########################################################
        mkvirtualenv:

            Make virtualenv with name and python version. Default with no version (system python).
            Usage: mkvirtualenv project_name {2.7|3.3}
        #########################################################
        

        #########################################################
        rmvirtualenv:

            Remove virtualenv with name.
            Usage: rmvirtualenv project_name
        #########################################################
        

        #########################################################
        usevirtualenv:

            Use virtualenv with name.
            Usage: usevirtualenv project_name
        #########################################################
        

        #########################################################
        cdvirtualenv:

            Use virtualenv and change to project with name or directory with same name as virtualenv.
            Usage: cdvirtualenv virtualenv_name {project_name}
        #########################################################
        

        #########################################################
        kafka_service:

            Run kafka with zookeeper docker compose.
            Usage: kafka_service (start|stop|restart)
        #########################################################
        

        #########################################################
        mysql_service:

            Run mysql docker.
            Usage: mysql_service (start|stop|restart)
        #########################################################
        

        #########################################################
        redis_service:

            Run redis docker.
            Usage: redis_service (start|stop|restart)
        #########################################################
        

        #########################################################
        elasticsearch_service:

            Run elasticsearch docker.
            Usage: elasticsearch_service (start|stop|restart)
        #########################################################
        

        #########################################################
        mongo_service:

            Run mongodb docker.
            Usage: mongo_service (start|stop|restart)
        #########################################################
        

        #########################################################
        zookeeper_service:

            Run zookeeper docker.
            Usage: zookeeper_service (start|stop|restart)
        #########################################################
        

        #########################################################
        drun:

            Run command on docker with any image.
            Usage: drun cogniteev/oracle-java:java8 "df -h"
        #########################################################
        

        #########################################################
        drun_java8:

            Run command on docker with java 8 image cogniteev/oracle-java:java8.
            Usage: drun_java8 df -h
        #########################################################
        
