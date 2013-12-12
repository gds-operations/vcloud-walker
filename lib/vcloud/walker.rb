require 'thor'
require 'json'
require 'fog'

require 'vcloud/walker/vcloud_session'
require 'vcloud/walker/fog_interface'
require 'vcloud/walker/resource'

module Vcloud
  module Walker

    def self.walk(resource_to_walk)
      print JSON.pretty_generate case resource_to_walk
        when 'catalogs'
          Vcloud::Walker::Resource::Organization.catalogs
        when 'vdcs'
          Vcloud::Walker::Resource::Organization.vdcs
        when 'networks'
          Vcloud::Walker::Resource::Organization.networks
        when 'edgegateways'
          Vcloud::Walker::Resource::Organization.edgegateways
        when 'organization'
          Vcloud::Walker::Resource::Organization.all
        else
          puts 'Please enter a valid resource; one of x, y, z...'
        end
    end

  end
end
