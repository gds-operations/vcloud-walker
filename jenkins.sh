#!/bin/bash -x
set -e

./jenkins_tests.sh
bundle exec rake publish_gem
