$:.unshift File.expand_path("../../lib", __FILE__)

require 'rspec'
require 'rspec/mocks'
require 'json_spec'
require 'vcloud/walker'
require_relative 'stubs/stubs'
require_relative 'stubs/service_layer_stub'


def set_login_credential username = 'some-username', password = 'some-password'
  ENV['API_USERNAME'] = username
  ENV['API_PASSWORD'] = password
end

RSpec.configure do |config|
  config.include JsonSpec::Helpers
end
