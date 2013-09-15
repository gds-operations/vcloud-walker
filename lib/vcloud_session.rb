class VcloudSession

  SKYSCAPE_API = 'api.vcd.portal.skyscapecloud.com'
  API_VERSION = '5.1'
  TIMEOUT = 200

  def self.instance
    @@session ||= Fog::Compute::VcloudDirector.new(
        :vcloud_director_host => SKYSCAPE_API,
        :vcloud_director_username => '260.3.4edba2@4-3-37-b5567e',
        :vcloud_director_password => ENV['SKYSCAPE_PASSWORD'],
        :vcloud_director_api_version => API_VERSION,
        :connection_options => {:omit_default_port => true, :connect_timeout => TIMEOUT, :read_timeout => TIMEOUT})
  end
end

#'4-3-37-b5567e'
