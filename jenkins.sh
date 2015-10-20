#!/bin/bash
set -e

./jenkins_tests.sh

source ./rbenv_version.sh
bundle exec rake publish_gem
