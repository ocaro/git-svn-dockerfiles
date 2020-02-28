#!/bin/sh

#
# Configure git author name, email, and HTTP login timeout on a git repository.
#

if [ -z "$(git config --global user.name)" ]; then
    if [ -z "$AUTHOR_NAME" ]; then
        echo "err: AUTHOR_NAME is not set." >&2
        exit 1
    fi
    git config user.name "$AUTHOR_NAME"
fi

if [ -z "$(git config --global user.email)" ]; then
    if [ -z "$AUTHOR_EMAIL" ]; then
        echo "err: AUTHOR_EMAIL is not set." >&2
        exit 1
    fi
    git config user.email "$AUTHOR_EMAIL"
fi

# if [ -z "$(git config --global credential.helper)" ]; then
#     if [ -z "$CREDENTIAL_CACHE" ]; then
#         echo "Using credential helper cache timeout set to $CREDENTIAL_CACHE."
#         CREDENTIAL_CACHE="3600"
#     fi
#     git config credential.helper "cache --timeout $CREDENTIAL_CACHE"
# fi
