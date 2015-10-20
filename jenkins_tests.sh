#!/bin/bash
set -eu

function cleanup {
  set +e
  bundle exec vcloud-logout
  rm $FOG_RC
  unset FOG_RC
}

export FOG_RC=$(mktemp /tmp/vcloud_fog_rc.XXXXXXXXXX)
trap cleanup EXIT

cat <<EOF >${FOG_RC}
${FOG_CREDENTIAL}:
  vcloud_director_host: '${API_HOST}'
  vcloud_director_username: '${API_USERNAME}'
  vcloud_director_password: ''
EOF

rm -f Gemfile.lock

source ./rbenv_version.sh

git clean -fdx

bundle install --path "${HOME}/bundles/${JOB_NAME}"
bundle exec rake

# Never log token to STDOUT.
set +x
eval $(printenv API_PASSWORD | bundle exec vcloud-login)

bundle exec rake integration
