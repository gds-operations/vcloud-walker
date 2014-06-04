module Vcloud
  module Walker
    module Resource
      class VApp < Entity
        attr_reader :id, :name, :status, :description, :network_config, :vms, :deployed, :network_section, :metadata

        def initialize fog_vapp
          @name = fog_vapp[:name]
          @status = fog_vapp[:status]
          @description = fog_vapp[:Description]
          @deployed = fog_vapp[:deployed]
          @id = extract_id(fog_vapp[:href])
          @network_config  = extract_network_config(fog_vapp)
          @network_section = extract_network_section(fog_vapp)
          @vms             = Resource::Vms.new(fog_vapp[:Children][:Vm])
          @metadata = Vcloud::Core::Vapp.get_metadata(id)
        end

        private
        def extract_network_config fog_vapp
          return [] unless fog_vapp.key?(:NetworkConfigSection)
          return [] unless fog_vapp[:NetworkConfigSection].key?(:NetworkConfig)

          network_configs = fog_vapp[:NetworkConfigSection][:NetworkConfig]
          (network_configs.is_a?(Hash) ? [network_configs] : network_configs).collect do |network_config|
            {
              network_name:   network_config[:networkName],
              is_deployed:    network_config[:IsDeployed],
              description:    network_config[:Description],
              config:         {
                ipscopes: network_config[:Configuration][:IpScopes]
              },
              parent_network: network_config[:Configuration][:ParentNetwork] ? network_config[:Configuration][:ParentNetwork][:name] : nil
            }
          end
        end

        def extract_network_section fog_vapp
          return {} unless fog_vapp.key?(:'ovf:NetworkSection')

          fog_vapp[:'ovf:NetworkSection'].fetch(:'ovf:Network', {})
        end
      end

      class VApps < Collection
        def initialize ids
          ids.each do |vapp_id|
            vapp = FogInterface.get_vapp(vapp_id)
            self << Resource::VApp.new(vapp)
          end
        end
      end
    end
  end
end
