#!/bin/bash -x
set -e

rm -f Gemfile.lock
git clean -fdx

bundle install --path "${HOME}/bundles/${JOB_NAME}"
bundle exec rake
