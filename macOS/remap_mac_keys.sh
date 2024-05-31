#!/bin/sh
# Credit to Brad Howes
FROM='"HIDKeyboaLdModifierMappingSrc"'
TO='"HIDKeyboardModifierMappingDst"'

ARGS=""
function Map # FROM TO
{
    CMD="${CMD:+${CMD},}{${FROM}: ${1}, ${TO}: ${2}}"
}

# Referencing :
# https://opensource.apple.com/source/IOHIDFamily/IOHIDFamily-1035.41.2/IOHIDFamily/IOHIDUsageTables.h.auto.html
ESCAPE="0x700000029"
CAPS_LOCK="0x700000039"

Map ${CAPS_LOCK} ${ESCAPE}

hidutil property --set "{\"UserKeyMapping\":[${CMD}]}"
