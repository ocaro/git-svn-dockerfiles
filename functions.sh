#!/bin/sh

err() {
    printf "error: $1\n" >&2
}

warn() {
    printf "warn: $1\n" >&2
}

info() {
    printf "info: $1\n"
}

debug() {
    if [ "$DEBUG" = true ]; then
        printf "debug: $1\n" >&2
    fi
}

has_longopts() {
    if [ "$(uname -s)" = "Linux" ]; then
        echo "longopts"
    else
        echo "shortopts"
    fi
}

isdefined_usage() {
    if [ $(expr "$(type usage)" : '.*function.*') -eq 0 ]; then
        err "usage function not defined."
        exit 1
    fi
}

onerror_exit() {
    if [ $? -ne 0 ]; then
        err "cannot continue; status: $?"
        exit 1
    fi
    if [ $(expr "$1" : '(^Access denied|.*Authentication problem).*') -gt 0 ]; then
        err "$1"
        exit 1
    fi
}