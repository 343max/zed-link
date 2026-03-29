#!/bin/sh

WORKSPACE="$(realpath "${1:-$PWD}")"
if [ -n "$ZEDLINK_HOST" ]; then
    HOSTNAME="$ZEDLINK_HOST"
elif [ -n "$SSH_CONNECTION" ]; then
    HOSTNAME="$(echo "$SSH_CONNECTION" | awk '{print $3}')"
else
    HOSTNAME="$(/bin/hostname)"
fi

URL="zed://ssh/$HOSTNAME$WORKSPACE"
ENCODED="$(echo -n $URL | base64 -w 0)"

# WezTerm: Set user var for Lua handling
printf "\033]1337;SetUserVar=%s=%s\007" open_url $ENCODED

# OSC 8: Hyperlink for clickable URLs in most modern terminals
printf "\033]8;;%s\033\\%s\033]8;;\033\n" "$URL" "$URL"
