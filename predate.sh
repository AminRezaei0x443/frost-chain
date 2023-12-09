#!/bin/bash

while read line; do
  echo $(date +%s%3N) ":" $line;    
done