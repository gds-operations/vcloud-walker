specdir=File.dirname(__FILE__)
Dir[File.join(specdir,'../lib/**/*.rb')].each {|f| require f }

require 'rspec'
require 'rspec/mocks'
