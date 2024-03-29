function cb
{
		luminosity=$1

		if [ -z "$luminosity" ]
		then
				echo "Pass the desired luminosity percentage (1 - 100) as the first argument"
				return 1
		fi

		for i in $(ddccontrol -p 2> /dev/null | grep " - Device" | cut -d: -f3)
		do
				ddccontrol -r 0x10 -w $luminosity dev:$i > /dev/null 2>&1
		done
}

function mkcd
{
		mkdir -p $1
		cd  $1
}

function uncompress_file
{
  local file="$1"
  local filename="$(basename "$file")"
  local extension="${filename##*.}"

  case "$extension" in
    "tar")
      tar xf "$file" ;;
    "tar.gz"|"tgz")
      tar xzf "$file" ;;
    "tar.bz2"|"tbz2")
      tar xjf "$file" ;;
    "tar.xz"|"txz")
      tar xJf "$file" ;;
    "zip")
      unzip "$file" ;;
    "rar")
      unrar x "$file" ;;
    *)
      echo "Unsupported file format: $file" ;;
  esac
}

function b
{
		nb_processes=10

		if [[ "$1" =~ ^[1-9][0-9]*$ ]]
		then
				nb_processes=$1
		fi

		[ -f Makefile ] && make -j 10 && return
		[ -f build/Makefile ] && make -C build -j 10 && return
		[ -f build.ninja ] && ninja -j 10 && return
		[ -f build/build.ninja ] && ninja -C build -j 10 && return
}

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

# function en
# {
#     [ -f ~/.config/mine/tmp_find_results ] || (printf "No find results to look into\n" && exit 1)

#     for i in $*; do
# 				FILENAME=$(awk "/^$i / { print \$2 }" ~/.config/mine/tmp_find_results)
# 				emacsclient -n "$FILENAME"
#     done
# }

function cn
{
    [ -f ~/.config/mine/tmp_find_results ] || (printf "No find results to look into\n" && exit 1)

    DIRNAME=$(awk "/^$1 / { print \$2 }" ~/.config/mine/tmp_find_results)
    cd $DIRNAME
}

# git conflicted
function gconflicted
{
    for i in `git status -s | grep -v "^\#" | awk '/^(UU|AA) / { print $2} '`; do emacsclient -n $i; done
}

# git grep
function gg
{
		if [ -z "$1" ]
		then
				echo "A string/regex should be passed as first argument of this command"
		fi

		git grep $1 $(git rev-list --all)
}

# git last 10 modified branches
function glmb
{
    for branch in `git branch -r | grep -v HEAD`;do echo -e `git show --format="%ci %cr" $branch | head -n 1` \\t$branch; done | sort -r | head -n 10
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
