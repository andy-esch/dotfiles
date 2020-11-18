# Andy Eschbacher, bashrc
# MacBook Pro, 2020

eval "$(pipenv --completion)"
# git bash completion
source /usr/local/etc/bash_completion.d/git-completion.bash
# show git branch in terminal
source /usr/local/etc/bash_completion.d/git-prompt.sh

# for matplotlib use in virtualenvs
function frameworkpython {
    if [[ ! -z "$VIRTUAL_ENV" ]]; then
        PYTHONHOME=$VIRTUAL_ENV /usr/local/bin/python3 "$@"
    else
       /usr/local/bin/python3 "$@"
    fi
}

# powerline
powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
# export POWERLINE_CONFIG_COMMAND="/usr/local/bin/powerline-config"
. /usr/local/lib/python3.7/site-packages/powerline/bindings/bash/powerline.sh

# Environment variables
export EDITOR="vim"
export PIPENV_SKIP_LOCK=True
export AIRFLOW_HOME=~/airflow

## project directories
export andy=$HOME"/git/andy-esch/"
export notes=$HOME"/git/andy-esch/notes/"
export git=$HOME"/git/"

# Update PATH

### Add local bin
export PATH=~/bin:$PATH
### sbin
export PATH=/usr/local/bin:/usr/local/sbin:$PATH

### Python-y path
export PATH=/usr/local/share/python3:$PATH

# TODO: REMOVE - no longer in use
## PostgreSQL Environment Variables
export PGPASSWORD="postgres"
export PGUSER="postgres"
### postgresql server stuffs
export PATH=/opt/local/lib/postgresql95/bin:$PATH

# bash-completion
if [ -f /opt/local/etc/profile.d/bash_completion.sh ]; then
	. /opt/local/etc/profile.d/bash_completion.sh
fi

## Utility functions

# change tab name
function tabname {
	printf "\e]1;$1\a"
}

# make directory, go into it
function mkcd {
	mkdir $@;
	cd $@;
}

function exit_if_no_jobs() {
    local running=$(jobs -rp | wc -l);
    if [ $running -gt 0 ]
    then
      echo "Cannot exit, "$running" jobs are running";
    else
      exit;
    fi;
}

alias ej='exit_if_no_jobs';

# TODO: remove - no longer in use
alias postgres_start='sudo /opt/local/etc/LaunchDaemons/org.macports.postgresql95-server/postgresql95-server.wrapper start';
alias postgres_stop='sudo /opt/local/etc/LaunchDaemons/org.macports.postgresql95-server/postgresql95-server.wrapper stop';
alias postgres_restart='sudo /opt/local/etc/LaunchDaemons/org.macports.postgresql95-server/postgresql95-server.wrapper restart';

# TODO: remove - no longer in use
# See if a port is installed
portinst() { port echo installed | grep "$@"; }

# Common commands reformulated
alias rm='rm -i'
alias cp='cp -iv'
alias mv='mv -iv'
alias mkdir='mkdir -pv'
alias ll='ls -FGlAhp'
alias lf="ls -l | egrep -v '^d'"
alias ldir="ls -l | egrep '^d'"

# Change to directory, list files
cd2() { builtin cd "$@"; ll; }

# git-related
alias gs="git status"
alias gsu="git status -uno"
alias gsd="git status ."

# workflow
# install common libraries and default python
# alias pisr="pipenv install jupyterlab cartoframes seaborn"
# easy start notebook
alias prjl="pipenv run jupyter lab"
# setup standard work environment
alias tsc="tmuxinator start carto"
alias pi="pipenv install"

pisr() {
    pipenv --three
    pipenv install jupyterlab cartoframes seaborn black
    pipenv run jupyter labextension install @jupyterlab/toc
}


# Start simple Python server in current directory
# setup basic http server from port 1234
# usage: pyserv 1234
pyserv() { 
    pyversion=$(python -c 'import sys; print(sys.version_info[:][0])')
    if [ "$#" -eq 1 ]; then
        s="$1"
    else
        s="8000"        
    fi
    
    echo "Staring HTTP Server in current directory on port "$s 
    if [ "$pyversion" -eq 2 ]; then
        python -m SimpleHTTPServer $s; 
    else
        python -m http.server $s;
    fi
}

# Different ways to view man pages
pman () {
	man -t "${1}" | open -f -a /Applications/Preview.app
}
tman () {
	MANWIDTH=160 MANPAGER='col -bx' man $@ | mate
}

alias ..="cd .."

# TODO: remove - no longer in use
alias portcheck='sudo port selfupdate && port echo outdated'


DROPBOX=~/Desktop/Dropbox/
CARTO=$HOME/Desktop/CARTO/
andy=$HOME/git/andy-esch

# Check out http://natelandau.com/my-mac-osx-bash_profile/ for ideas

# docker thingy for kaggle data sci install. Jan 18 2017
kjupyter() {
      ip="$(docker-machine ip docker2)"
      echo $ip
      if [ -z "$1" ]
      then
        hostnum="8889"
      else
        hostnum="$1"
      fi 
       (sleep 3 && open "http://$ip:$hostnum")&
          docker run -v $PWD:/tmp/working -w=/tmp/working -p $hostnum:8888 --rm -it cvxopt jupyter notebook --no-browser --ip="0.0.0.0" --notebook-dir=/tmp/working --config NotebookApp.token=''
      } 


docker_ssh() {
  docker exec -i -t $1 /bin/bash
}


# carto spark docker work
gpsdocker() {
    cd $CARTO/spark/
    docker run -d -P --name pyspark -v $PWD:/home/jovyan/work jupyter/pyspark-notebook:c1b0cf6bf4d6 start-notebook.sh --NotebookApp.token=''
    echo "running pyspark on: "$(docker port pyspark)
}

# TODO - is the in use?
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Google Cloud things
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/aeschbacher/.gcloud/google-cloud-sdk/path.bash.inc' ]; then . '/Users/aeschbacher/.gcloud/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/aeschbacher/.gcloud/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/aeschbacher/.gcloud/google-cloud-sdk/completion.bash.inc'; fi
