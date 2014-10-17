#!/bin/bash

[ -z "$TARGET_DIR" ] && exit 1

cd "$TARGET_DIR"

rm -rf root/.bash_* home/ftp
