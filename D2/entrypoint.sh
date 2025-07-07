#!/bin/bash

echo "Waiting for D1 remote..."

until git ls-remote http://d1/git/testrepo.git; do
      echo "D1 not reachable..."
      sleep 2
done
sleep 5
echo "------------------------"
git clone http://d1/git/testrepo.git /tmp/testrepo  
echo "Content of README.md: $(cat /tmp/testrepo/README.md)"
