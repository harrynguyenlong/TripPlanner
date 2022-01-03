#!/bin/bash

#Log debug branch
BRANCH=$(if [ "$TRAVIS_PULL_REQUEST" == "false" ]; then echo $TRAVIS_BRANCH; else echo $TRAVIS_PULL_REQUEST_BRANCH; fi)
echo "TRAVIS_BRANCH=$TRAVIS_BRANCH, PR=$PR, BRANCH=$BRANCH"

if [ "$TRAVIS_BRANCH" == "develop" ]
then
  echo "********** BUILD DEV **********"
  bundle exec fastlane unit_tests
  bundle exec fastlane ui_tests
fi
