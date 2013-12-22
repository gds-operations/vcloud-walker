require 'thor'
require 'fog'

require 'vcloud/walker/vcloud_session'
require 'vcloud/walker/fog_interface'
require 'vcloud/walker/resource'

module Vcloud
  module Walker

    def self.walk(resource_to_walk)
      valid_options = ['catalogs', 'vdcs', 'networks',
                        'edgegateways', 'organization']
      if valid_options.include? resource_to_walk
        case resource_to_walk
          when 'catalogs'
            Vcloud::Walker::Resource::Organization.catalogs
          when 'vdcs'
            Vcloud::Walker::Resource::Organization.vdcs
          when 'networks'
            Vcloud::Walker::Resource::Organization.networks
          when 'edgegateways'
            Vcloud::Walker::Resource::Organization.edgegateways
          when 'organization'
            Vcloud::Walker::Resource::Organization.organization
        end
      else
         puts "Possible options are '#{valid_options.join("','")}'."
      end
    end

  end
end
