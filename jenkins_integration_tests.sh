#!/bin/bash -x
set -e
bundle install --path "${HOME}/bundles/${JOB_NAME}"

RUBYOPT="-r ./tools/fog_credentials" bundle exec rake integration
