#!/bin/sh

#
# Prettifies a svn author as a git author; includes the email if the `EMAIL_DOMAIN` environment variable is set.
#
ret="$($(dirname $0)/pu.sh $1)"
if [ $? -ne 0 ]; then
  echo "Usage: $(basename $0) <userid>" >&2
  exit 1
fi
if [ "$EMAIL_DOMAIN" != "" ]; then
  ret="$ret <$1@$EMAIL_DOMAIN>"
else
  ret="$ret <>"
fi
echo $ret
