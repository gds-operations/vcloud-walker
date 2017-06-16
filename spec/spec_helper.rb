# SimpleCov must run _first_ according to its README
if ENV['COVERAGE']
  require 'simplecov'

  # monkey-patch to prevent SimpleCov from reporting coverage percentage
  class SimpleCov::Formatter::HTMLFormatter
    def output_message(_message)
      nil
    end
  end

  if SimpleCov.profiles[:gem].nil?
    SimpleCov.profiles.define 'gem' do
      add_filter '/spec/'
      add_filter '/vendor/'

      add_group 'Libraries', '/lib/'
    end
  end

  SimpleCov.minimum_coverage(99)
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
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
