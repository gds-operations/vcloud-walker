# Initialiser for getting vCloud credentials into Fog from Jenkins build
# parameters, without needing to write them to disk. To be used with:
#
#     RUBYOPT="-r ./tools/fog_credentials" bundle exec integration
#
# Replace with FOG_VCLOUD_TOKEN support when we have a tool:
#
#     https://www.pivotaltracker.com/story/show/68989754
#
require 'bundler/setup'
require 'fog'

Fog.credentials = {
  :vcloud_director_host     => ENV['API_HOST'],
  :vcloud_director_username => ENV['API_USERNAME'],
  :vcloud_director_password => ENV['API_PASSWORD'],
}
