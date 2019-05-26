#!/bin/bash

. /etc/portage/make.conf

PCFLAGS="${CFLAGS}"

make CFLAGS="${PCFLAGS}" local_install
