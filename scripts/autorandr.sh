#!/bin/bash

path="$(which autorandr)"

if [ -f $path ]; then
    autorandr -c
fi
