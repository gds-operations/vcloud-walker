require 'thor'
require 'fog'

require 'vcloud/core'
require 'vcloud/walker/vcloud_session'
require 'vcloud/walker/fog_interface'
require 'vcloud/walker/resource'
require 'vcloud/walker/version'

module Vcloud
  module Walker

    def self.walk(resource_to_walk)
      valid_options = ['catalogs', 'vdcs', 'networks',
                        'edgegateways', 'organization']
      if valid_options.include? resource_to_walk
        Vcloud::Walker::Resource::Organization.send(resource_to_walk)
      else
         puts "Possible options are '#{valid_options.join("','")}'."
      end
    end

  end
end
