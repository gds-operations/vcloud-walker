class VcloudSession

  API_URL = 'api.vcd.portal.skyscapecloud.com'

  def self.instance
    raise ArgumentError.new('API credentials not found !') unless ENV['API_USERNAME'] && ENV['API_PASSWORD']

    Fog::Compute::VcloudDirector.new(
      :vcloud_director_host => API_URL,
      :vcloud_director_username => ENV['API_USERNAME'],
      :vcloud_director_password => ENV['API_PASSWORD'],
    )
  end

end

