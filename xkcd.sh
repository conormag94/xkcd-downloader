#!/bin/bash

# Pull XKCD's most recent comic, saving JSON result to temp file
echo "Searching XKCD..."
curl -G -s http://xkcd.com/info.0.json | json_pp > res.json 

# Extract latest comic number from json file (a number followed by a comma)
grep -E -o '\d+,' res.json > num.txt
TEMP=`cat num.txt`

# Remove comma found by regex
COMIC_NUM=${TEMP%?}
echo "Current comic: #$COMIC_NUM"

# Extract url for latest XKCD and save to temp file
grep -o http:\/\/\[a-z\.\/_\]\* res.json  > url.txt

# Download png from the url listed in the temp file
cat url.txt | xargs curl -G -s -o $COMIC_NUM.png
rm url.txt
rm res.json
echo "XKCD #$COMIC_NUM saved!"

