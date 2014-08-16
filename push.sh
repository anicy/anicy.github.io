#!/bin/bash

# a script help me to push the code to the site of github
if [ $# -eq 0 ]
then
    message="auto commit by push.sh  ...."
else
    message=$*
fi

git add -u

git add .

git status

echo $message

git commit -m "$message"

git push origin master

echo "code have been push to remote now..."
