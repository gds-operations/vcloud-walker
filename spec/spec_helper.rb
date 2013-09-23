specdir=File.dirname(__FILE__)
require File.join(specdir,'../lib/walk/walk.rb')

require 'rspec'
require 'rspec/mocks'

def set_login_credential username = 'some-username', password = 'some-password'
  ENV['API_USERNAME'] = username
  ENV['API_PASSWORD'] = password
end