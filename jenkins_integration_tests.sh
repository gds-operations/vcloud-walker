#!/bin/bash -x
set -e
bundle install --path "${HOME}/bundles/${JOB_NAME}"

./scripts/generate_fog_conf_file.sh

echo "switching on walker ci"
export FOG_RC=fog_integration_test.config
bundle exec ruby scripts/switch_power_for_walker_ci.rb on

bundle exec rake integration_test

echo "switching off walker ci after test run"
bundle exec ruby scripts/switch_power_for_walker_ci.rb off
rm fog_integration_test.config
