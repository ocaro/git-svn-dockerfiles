#!/bin/sh
#
# Prettifies a svn author as a git author including the email using a domain variable.
#

from_first_dot_last() {
  echo "$(sed -E -n 's/^([^ \t\.]+)\.([^ \t\.]+)$/\u\2, \u\1 \<\>/p')";
}

from_flast() {
  echo "$(sed -E 's/([^ \t\.])([^ \t\.]+)/\u\2, \u\1 \<\>/')"
}

ret="$(echo $1 | from_first_dot_last)"
if [ "$ret" = "" ]; then
  ret="$(echo $1 | from_flast)"
fi
# Adds email.
if [ "$DOMAIN" != "" ]; then
  ret="$(echo $ret | sed -E "s/<>/<$1@$DOMAIN>/")"
fi
echo $ret