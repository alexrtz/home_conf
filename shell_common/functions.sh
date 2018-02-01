function f
{
    rm -f ~/.config/mine/tmp_find_results

    n=1;

    for i in $(find . -iname \*$1\*); do
	echo "$n $i"
	echo "$n $i" >> ~/.config/mine/tmp_find_results
	n=$(($n+1))
    done
}

function en
{
    [ -f ~/.config/mine/tmp_find_results ] || (printf "No find results to look into\n" && exit 1)

    for i in $*; do
	FILENAME=$(awk "/^$i / { print \$2 }" ~/.config/mine/tmp_find_results)
	emacsclient -n "$FILENAME"
    done
}

function cn
{
    [ -f ~/.config/mine/tmp_find_results ] || (printf "No find results to look into\n" && exit 1)

    DIRNAME=$(awk "/^$1 / { print \$2 }" ~/.config/mine/tmp_find_results)
    cd $DIRNAME
}



# git conflicted
function gconflicted
{
    for i in `git status -s | awk '/^UU / { print $2} '`; do emacsclient -n $i; done
}

# git modified
function gmodified
{
    for i in `git status -s | grep -v \? | sed -re 's/^[ ]?[AM]{1,2} //'`; do emacsclient -n $i; done
}

function svn_conflicted
{
    for i in `svn st | grep -E '^[ ]?C' | cut -d' ' -f8`; do emacsclient -n $i; done
}



function docker_purge_images
{
    for i in `docker images|grep none|awk -F" " '{print $3}'`; do docker rmi $i; done
}

function docker_purge_containers
{
    for i in `docker ps -a | grep -v 'CONTAINER ID' | cut -d' ' -f1`; do docker stop $i; docker rm $i; done
}

man() {
      env \
         LESS_TERMCAP_mb=$(printf "\e[1;31m") \
         LESS_TERMCAP_md=$(printf "\e[1;31m") \
         LESS_TERMCAP_me=$(printf "\e[0m") \
         LESS_TERMCAP_se=$(printf "\e[0m") \
         LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
         LESS_TERMCAP_ue=$(printf "\e[0m") \
         LESS_TERMCAP_us=$(printf "\e[1;32m") \
               man "$@"
}
