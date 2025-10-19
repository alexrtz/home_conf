function mkcd
{
		mkdir -p $1
		cd  $1
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

function c
{
    if [ $# -lt 1 ]
		then
        echo "Usage: tarfzstd <file-or-directory> [output.zst|output.tar.zst]"
        return 1
    fi

    local input="$1"
    local outfile="$2"

    if [ ! -e "$input" ]
		then
        echo "Error: '$input' does not exist."
        return 1
    fi

    if [ -z "$outfile" ]
		then
        if [ -d "$input" ]
				then
            outfile="${input%/}.tar.zst"
        else
            outfile="${input}.zst"
        fi
    fi

    if [ -d "$input" ]
		then
        tar -cf - "$input" | zstd -T0 -19 -o "$outfile"
    elif [ -f "$input" ]
		then
        zstd -T0 -19 -o "$outfile" "$input"
    else
        echo "Error: '$input' is neither a file nor a directory."
        return 1
    fi
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

function man
{
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

function x
{
    if [ -z "$1" ]; then
        echo "Usage: extract <archive>"
        return 1
    elif [ ! -f "$1" ]; then
        echo "Error: '$1' is not a valid file"
        return 1
    fi

    case "$1" in
        *.tar.bz2)   tar xjf "$1"    ;;
        *.tar.gz)    tar xzf "$1"    ;;
        *.tar.xz)    tar xJf "$1"    ;;
        *.tar.zst)   unzstd "$1" && tar xf "${1%.zst}" ;;
        *.tar)       tar xf "$1"     ;;
        *.tbz2)      tar xjf "$1"    ;;
        *.tgz)       tar xzf "$1"    ;;
        *.bz2)       bunzip2 "$1"    ;;
        *.gz)        gunzip "$1"     ;;
        *.xz)        unxz "$1"       ;;
        *.zst)       unzstd "$1"     ;;
        *.zip)       unzip "$1"      ;;
        *.rar)       unrar x "$1"    ;;
        *.7z)        7z x "$1"       ;;
        *.tar.lz)    lzip -d "$1" && tar xf "${1%.lz}" ;;
        *.lzma)      unlzma "$1"     ;;
        *.lz)        lzip -d "$1"    ;;
        *.Z)         uncompress "$1" ;;
        *)           echo "Error: cannot extract '$1' — unsupported format" ;;
    esac
}
