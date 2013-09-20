class VcloudSession

  API_URL = 'api.vcd.portal.skyscapecloud.com'
  API_VERSION = '5.1'
  TIMEOUT = 200

  def self.instance
    raise ArgumentError.new('API credentials not found !') unless ENV['API_USERNAME'] && ENV['API_PASSWORD']

    Fog::Compute::VcloudDirector.new(
        :vcloud_director_host => API_URL,
        :vcloud_director_username => ENV['API_USERNAME'],
        :vcloud_director_password => ENV['API_PASSWORD'],
        :vcloud_director_api_version => API_VERSION,
        :connection_options => {:omit_default_port => true, :connect_timeout => TIMEOUT, :read_timeout => TIMEOUT})
  end
end

