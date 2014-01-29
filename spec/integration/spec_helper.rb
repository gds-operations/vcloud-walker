$:.unshift File.expand_path("../../lib", __FILE__)

require 'rspec'
require 'rspec/mocks'
require 'json_spec'
require 'vcloud/walker'

RSpec.configure do |config|
  config.include JsonSpec::Helpers
end

