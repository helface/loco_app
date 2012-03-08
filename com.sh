#! /bin/bash
echo -n "comment:"
read -e COMMENT
git add .
git commit -m $COMMENT
git push
git push heroku master
