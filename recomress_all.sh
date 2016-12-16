#!/bin/bash

date

docker run --rm -v="$(pwd):/imgcrush" komplizierte/imgcrush -c 4 -o done . | cut -d ' ' -f2 | while read FILE
do
  echo $FILE
  if [ -a "done/$FILE" ]
  then
    chown 33:33 done/$FILE
    yes|cp -f done/$FILE $FILE
    rm -f done/$FILE
  fi
done

echo "::COMEPLETE"
date

rm -rf ./done
