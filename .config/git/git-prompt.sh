if test -f /etc/profile.d/git-sdk.sh
then
    TITLEPREFIX=SDK-${MSYSTEM#MINGW}
else
    TITLEPREFIX=$MSYSTEM
fi

if test -f ~/.config/git/git-prompt.sh
then
    . ~/.config/git/git-prompt.sh
else
    PS1='\[\033]0;🔴🟡🟢\007\]'    
    PS1="$PS1"'\n'

    PS1="$PS1"'\[\033[94m\]'
    PS1="$PS1"'\u'                

    PS1="$PS1"'\[\033[95m\]'
    PS1="$PS1"' λ '

    PS1="$PS1"'\[\033[94m\]'
    PS1="$PS1"'\h '

    PS1="$PS1"'\[\033[35m\]'
    PS1="$PS1"'🐰 '

    PS1="$PS1"'\[\033[92m\]'
    PS1="$PS1"'⬢ v22.16.0 '

    PS1="$PS1"'\[\033[33m\]'
    PS1="$PS1"'\w'

    if test -z "$WINELOADERNOEXEC"
    then
        GIT_EXEC_PATH="$(git --exec-path 2>/dev/null)"
        COMPLETION_PATH="${GIT_EXEC_PATH%/libexec/git-core}"
        COMPLETION_PATH="${COMPLETION_PATH%/lib/git-core}"
        COMPLETION_PATH="$COMPLETION_PATH/share/git/completion"
        if test -f "$COMPLETION_PATH/git-prompt.sh"
        then
            . "$COMPLETION_PATH/git-completion.bash"
            . "$COMPLETION_PATH/git-prompt.sh"

            PS1="$PS1"'\[\033[36m\]'
            PS1="$PS1"'`__git_ps1`'
        fi
    fi

    PS1="$PS1"'\[\033[0m\]'
    PS1="$PS1"'\n'
    PS1="$PS1"'$ '
fi

MSYS2_PS1="$PS1"

if test -z "$WINELOADERNOEXEC"
then
    for c in "$HOME"/bash_completion.d/*.bash
    do
        test ! -f "$c" ||
        . "$c"
    done
fi
