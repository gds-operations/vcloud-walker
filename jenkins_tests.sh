#!/bin/bash -x
set -eu

function cleanup {
  rm $FOG_RC
}

# Override default of ~/.fog and delete afterwards.
export FOG_RC=$(mktemp /tmp/vcloud_fog_rc.XXXXXXXXXX)
trap cleanup EXIT

cat <<EOF >${FOG_RC}
${FOG_CREDENTIAL}:
  vcloud_director_host: '${API_HOST}'
  vcloud_director_username: '${API_USERNAME}'
  vcloud_director_password: ''
EOF

rm -f Gemfile.lock
git clean -fdx

bundle install --path "${HOME}/bundles/${JOB_NAME}"
bundle exec rake

eval $(printenv API_PASSWORD | bundle exec vcloud-login)
bundle exec rake integration
