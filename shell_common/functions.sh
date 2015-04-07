function svn_conflicted
{
    for i in `svn st | grep -E '^C' | cut -d' ' -f8`; do emacsclient -n $i; done
}
