#!/bin/sh

#
# Prettifies a user id as a full name using the format "Last, First".
#
if [ $# -eq 0 ]; then
	echo "Usage: $(basename $0) <userid>" >&2
  exit 1
fi

from_first_dot_last() {
  printf "%s%s, %s%s" \
    $(echo "$1" | cut -d\. -f 2 -s | cut -b 1 | tr '[:lower:]' '[:upper:]') \
    $(echo "$1" | cut -d\. -f 2 -s | cut -b 2- | tr '[:upper:]' '[:lower:]') \
    $(echo "$1" | cut -d\. -f 1 -s | cut -b 1 | tr '[:lower:]' '[:upper:]') \
    $(echo "$1" | cut -d\. -f 1 -s | cut -b 2- | tr '[:upper:]' '[:lower:]')
}

from_flast() {
  printf "%s%s, %s" \
    $(echo "$1" | cut -b 2- | cut -b 1 | tr '[:lower:]' '[:upper:]') \
    $(echo "$1" | cut -b 3- | tr '[:upper:]' '[:lower:]') \
    $(echo "$1" | cut -b 1 | tr '[:lower:]' '[:upper:]')
}

if [ "root" = "$1" ]; then
  ret="$1"
elif [ $(expr "$1" : '.*[.].*') -gt 0 ]; then
  ret="$(from_first_dot_last $1)"
else 
  ret="$(from_flast $1)"
fi
echo $ret
