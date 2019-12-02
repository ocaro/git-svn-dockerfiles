#!/bin/sh
#
# Prettifies a svn author as a git author; includes the email if the `email_domain` environment variable is set.
#
from_first_dot_last() {
  echo "$(sed -E -n 's/^([^ \t\.]+)\.([^ \t\.]+)$/\u\2, \u\1 \<\>/p')"
}
from_flast() {
  echo "$(sed -E -n 's/([^ \t\.])([^ \t\.]+)/\u\2, \u\1 \<\>/p')"
}
if [ $# -eq 0 ]; then
  echo "err: did you forget the svn author?" >&2
  exit 1
fi
ret="$(echo $1 | from_first_dot_last)"
if [ "$ret" = "" ]; then
  ret="$(echo $1 | from_flast)"
fi
if [ "$email_domain" != "" ]; then
  ret="$(echo $ret | sed -E -n "s/<>/<$1@$email_domain>/p")"
fi
echo $ret
