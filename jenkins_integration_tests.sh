#!/bin/bash -x
set -e
bundle install --path "${HOME}/bundles/${JOB_NAME}"
echo "switching on walker ci"
bundle exec ruby scripts/switch_power_for_walker_ci.rb on

bundle exec rake integration_test

echo "switching off walker ci after test run"
bundle exec ruby scripts/switch_power_for_walker_ci.rb off