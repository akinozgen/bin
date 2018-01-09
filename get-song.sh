#!/bin/bash

# http://github.com/MitchWeaver/bin
#
# -------------------------------------- #

# if [ "$(pgrep mpv)" ] ; then 
# gets current song from mpvc
song="`dash /usr/local/bin/mpvc -f \"%artist% - %title%\"`"
if [[ "$song" =~ .*N/A.* ]] ; then
    song="`dash /usr/local/bin/mpvc -f \"%file%\"`"
elif [[ "$song" =~ .*MPV.* ]] ; then
    song=""
fi
# elif [ "$(pgrep mpd)" ] ; then 
#     # gets current song from mpd
#     song="`mpc -q current 2> /dev/null`"
# else
#     exit
# fi


# max length before truncation
if [ $# -eq 0 ] ; then
    max_len=40
else
    max_len="$1"
fi

# what to append on a truncation
if [ $# -lt 2 ] ; then
    trunc="..."
else
    trunc="$2"
fi
# -------------------------------------- #

if [ ! -z "$song" ] ; then
    # chop off filename
    song=${song%".opus"}
    song=${song%".flac"}
    song=${song%".ogg"}
    song=${song%".mp3"}
    song=${song%".wav"}
    song=${song%".cue"}

    # if its too long, trim it down
    if [ ${#song} -gt $max_len ] ; then
        song=`echo "$song" | cut -c1-$max_len`
        song="${song}$trunc"
    fi

    # echo "[ ♫ $song ] ∙"
    echo "$song"

else
    # has to be " " or else NULL causes errors in slstatus
    echo " "
fi
