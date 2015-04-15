#!/bin/bash
exec > >(logger -s -t $(basename $0)) 2>&1 #sends script output to Logger so it appears in the system log
echo "Deleting all Keychains..."
rm -rf -v /Users/*/Library/Keychains
echo "Keychains Deleted"