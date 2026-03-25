#!/bin/sh

WORKSPACE="$(cd "${1:-$PWD}" && pwd -P)"
if [ -n "$ZEDLINK_HOST" ]; then
    HOSTNAME="$ZEDLINK_HOST"
elif [ -n "$SSH_CONNECTION" ]; then
    HOSTNAME="$(echo "$SSH_CONNECTION" | awk '{print $3}')"
else
    HOSTNAME="$(/bin/hostname)"
fi

URL="zed://ssh/$HOSTNAME$WORKSPACE"
ENCODED="$(echo -n $URL | base64 -w 0)"

printf "\033]1337;SetUserVar=%s=%s\007" open_url $ENCODED
echo $URL
