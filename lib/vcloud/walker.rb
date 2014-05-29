require 'fog'

require 'vcloud/core'
require 'vcloud/walker/vcloud_session'
require 'vcloud/walker/fog_interface'
require 'vcloud/walker/resource'
require 'vcloud/walker/version'

module Vcloud
  module Walker
    VALID_RESOURCES = %w{catalogs vdcs networks edgegateways organization}

    def self.walk(resource_to_walk)
      unless VALID_RESOURCES.include?(resource_to_walk)
         raise "Invalid resource '#{resource_to_walk}'. Possible options are '#{VALID_RESOURCES.join("','")}'."
      end

      Vcloud::Walker::Resource::Organization.send(resource_to_walk)
    end

  end
end
