if ENV['COVERAGE']
  require 'simplecov'

  SimpleCov.profiles.define 'gem' do
    add_filter '/spec/'
    add_filter '/vendor/'

    add_group 'Libraries', '/lib/'
  end

  SimpleCov.start 'gem'
end

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

if ENV['COVERAGE']
  ACCEPTED_COVERAGE = 97
  SimpleCov.at_exit do
    SimpleCov.result.format!
    # do not change the coverage percentage, instead add more unit tests to fix coverage failures.
    if SimpleCov.result.covered_percent < ACCEPTED_COVERAGE
      print "ERROR::BAD_CODE_COVERAGE\n"
      print "Coverage is less than acceptable limit(#{ACCEPTED_COVERAGE}%). Please add more tests to improve the coverage"
      exit(1)
    end
  end
end
