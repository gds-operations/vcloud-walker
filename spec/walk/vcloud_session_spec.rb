require_relative '../spec_helper'
require 'rspec/mocks'

describe VcloudSession do
  context "session creation" do

    it "should throw argument error if username and password are not found" do
      ENV['API_USERNAME'] = nil
      ENV['API_PASSWORD'] = nil
      expect { VcloudSession.instance }.to raise_error(ArgumentError)
    end

    it "should return session if fog creates a valid session " do
      ENV['API_USERNAME'] = 'correct-user'
      ENV['API_PASSWORD'] = 'correct-password'

      mock_session = double(:fog_session)
      Fog::Compute::VcloudDirector.should_receive(:new)
                                  .with(:vcloud_director_host => 'api.vcd.portal.skyscapecloud.com',
                                        :vcloud_director_username => 'correct-user',
                                        :vcloud_director_password => 'correct-password',
                                        :vcloud_director_api_version => '5.1',
                                        :connection_options => {:omit_default_port => true, :connect_timeout => 200, :read_timeout => 200})
                                  .and_return(mock_session)

      VcloudSession.instance.should == mock_session

    end

  end
end