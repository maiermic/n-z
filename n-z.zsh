function n-z() {
    local NLIST_START_IN_SEARCH_MODE=1
    local NLIST_START_IN_UNIQ_MODE=1

    emulate -L zsh

    setopt extendedglob pushdignoredups

    zmodload zsh/curses
    local IFS="
    "

    # Unset before configuration is read
    unset NLIST_COLORING_PATTERN

    [ -f ~/.config/znt/n-list.conf ] && builtin source ~/.config/znt/n-list.conf
    [ -f ~/.config/znt/n-cd.conf ] && builtin source ~/.config/znt/n-cd.conf

    local list
    local selected

    NLIST_REMEMBER_STATE=0

    list=( `z -l ${@:1} | awk '{print $2}'` )

    local NLIST_GREP_STRING="$1"

    [ "$#list" -eq 0 ] && echo "No matching directories"

    if [ "$#hotlist" -ge 1 ]; then
        typeset -a NLIST_NONSELECTABLE_ELEMENTS NLIST_HOP_INDEXES
        local tmp_list_size="$#list"
        NLIST_NONSELECTABLE_ELEMENTS=( $(( tmp_list_size+1 )) $(( tmp_list_size+2 )) )
        list=( "$list[@]" "" $'\x1b[00;31m'"Hotlist"$'\x1b[00;00m': "$hotlist[@]" )
        (( tmp_list_size+=3 ))
        local middle_hop=$(( (tmp_list_size+$#list) / 2 ))
        [[ "$middle_hop" -eq $tmp_list_size || "$middle_hop" -eq $#list ]] && middle_hop=""
        [ "$tmp_list_size" -eq $#list ] && tmp_list_size=""
        NLIST_HOP_INDEXES=( 1 $tmp_list_size $middle_hop $#list )
    else
        [ "$#list" -eq 0 ] && return 1
    fi

    n-list "${list[@]}"

    if [ "$REPLY" -gt 0 ]; then
        selected="$reply[REPLY]"
        selected="${selected/#\~/$HOME}"

        (( NCD_DONT_PUSHD )) && setopt NO_AUTO_PUSHD
        cd "$selected"
        local code=$?
        (( NCD_DONT_PUSHD )) && setopt AUTO_PUSHD

        if [ "$code" -eq "0" ]; then
            # ZLE?
            if [ "${(t)CURSOR}" = "integer-local-special" ]; then
                zle -M "You have selected $selected"
            else
                echo "You have selected $selected"
            fi
        fi
    else
        [ "${(t)CURSOR}" = "integer-local-special" ] && zle redisplay
    fi

    unset NLIST_START_IN_SEARCH_MODE
    unset NLIST_START_IN_UNIQ_MODE
}

# vim: set filetype=zsh: