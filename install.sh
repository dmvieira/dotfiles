#!/usr/bin/env bash

shortcuts(){
    echo "#########################################"
    echo "Adding SHORTCUTS"
    echo "#########################################"
    export DOT_PATH=$(dirname $(realpath $0))
    grep -Fq "DOT_PATH" $HOME/.bash_profile || echo "export DOT_PATH=$DOT_PATH" >> $HOME/.bash_profile
    grep -Fq "dot_profile" $HOME/.bash_profile || echo "source $DOT_PATH/dot_profile" >> $HOME/.bash_profile
    source $HOME/.bash_profile

}

preinstall(){

    echo "#########################################"
    echo "Doing PREINSTALL"
    echo "#########################################"

    #brew
    which -s brew || ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" < /dev/null 2> /dev/null ; brew install caskroom/cask/brew-cask 2> /dev/null
    which -s realpath || brew install coreutils
    #xcode config
    xcode-select -p || sudo xcodebuild -license

}

dependencies()
{

    #deps
    echo "#########################################"
    echo "Installing DEPENDENCIES"
    echo "#########################################"
    #brew tap homebrew/cask-cask #Verify if still needed
    #brew tap caskroom/versions
    brew tap AdoptOpenJDK/openjdk
    brew update
    brew install adoptopenjdk8 --cask
    brew install docker --cask
    brew install wget 
    brew install gnu-tar
    brew install bash-completion
    brew install jenv
    brew install python3
    brew install openssl
    sudo easy_install pip    

    #python
    sudo pip install virtualenv
    sudo pip3 install virtualenv
    mkdir -p $VIRTUALENVS

    #autocomplete
    which -s rvm || curl -L https://get.rvm.io | bash -s stable --auto-dotfiles --autolibs=enable
    curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash

}

extras(){

    #extras
    echo "#########################################"
    echo "Installing EXTRAS"
    echo "#########################################"
    brew tap caskroom/cask
    brew update
    brew install iterm2 --cask
    brew install visual-studio-code --cask
    brew install intellij-idea-ce --cask
    brew install virtualbox --cask
    brew install sequel-pro --cask
    brew install node --cask
    brew install scala

}

spark(){

    #spark
    echo "#########################################"
    echo "Installing SPARK"
    echo "#########################################"
    curl https://archive.apache.org/dist/spark/spark-$SPARK_VERSION/spark-$SPARK_VERSION-bin-hadoop$HADOOP_SPARK_VERSION.tgz -o $SPARK_HOME.tgz
    rm -rf $SPARK_HOME
    tar xz -f $SPARK_HOME.tgz
    mv $DOT_PATH/spark-$SPARK_VERSION-bin-hadoop$HADOOP_SPARK_VERSION $SPARK_HOME
    rm $SPARK_HOME.tgz
}

hadoop(){

    #hadoop
    echo "#########################################"
    echo "Installing HADOOP"
    echo "#########################################"
    curl https://archive.apache.org/dist/hadoop/core/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz -o $HADOOP_HOME.tgz
    rm -rf $HADOOP_HOME
    tar xz -f $HADOOP_HOME.tgz
    mv $DOT_PATH/hadoop-$HADOOP_VERSION $HADOOP_HOME
    rm $HADOOP_HOME.tgz
}

case "$1" in
    shortcuts)
        shortcuts
        ;;
    dependencies)
        preinstall
        shortcuts
        dependencies
        ;;
    extras)
        preinstall
        extras
        ;;
    spark)
        spark            
        ;;   
    hadoop)
        shortcuts
        hadoop            
        ;;   
    all)
        preinstall
        dependencies
        extras
        spark
        hadoop
        ;;
    *)
        echo """
            Choose between
                - shortcuts (dot_files shortcuts and functions)
                - dependencies (dot_files dependencies)
                - extras (install and configure usefull extras)
                - spark (install and configure spark)
                - hadoop (install and configure hadoop)
                - all (for all above)
        """
esac

source $HOME/.bash_profile
