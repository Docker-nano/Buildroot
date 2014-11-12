#!/bin/bash

[ -n "$TARGET_DIR" ] || exit

cd "$TARGET_DIR"

rm -rf root/.bash_* home/ftp
