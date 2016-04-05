#!/bin/sh

if [ "$TRAVIS_REPO_SLUG" == "gelin/travis-javadoc-test" ] && [ "$TRAVIS_PULL_REQUEST" == "false" ] && [ "$TRAVIS_BRANCH" == "master" ]; then

  echo -e "Publishing javadoc...\n"

  cp -R target/site/apidocs $HOME/javadoc-latest

  cd $HOME
  git config --global user.email "travis@travis-ci.org"
  git config --global user.name "travis-ci"
  git clone --quiet --branch=master https://${GH_TOKEN}@github.com/gelin/gelin.github.io gh-pages > /dev/null

  cd gh-pages
  git rm -rf ./travis-javadoc-test/apidocs
  cp -Rf $HOME/javadoc-latest ./travis-javadoc-test/apidocs
  git add -f .
  git commit -m "Latest javadoc on successful travis build $TRAVIS_BUILD_NUMBER auto-pushed to gh-pages"
  git push -fq origin master > /dev/null

  echo -e "Published Javadoc to gh-pages.\n"

fi
