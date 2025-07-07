#!/bin/bash
set -e

echo "Cloning from D1..."

git clone http://d1/git/testrepo.git /tmp/testrepo

echo "------ README.md ------"
cat /tmp/testrepo/README.md
