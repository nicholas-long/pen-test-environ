#!/bin/bash

echo "$1" | cut -d '/' -f 1 | xargs apt show
