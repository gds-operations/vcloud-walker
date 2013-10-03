module Walk
  class VApp < Entity
    attr_reader :id, :name, :status, :description, :network_config, :vms, :deployed, :network_section

    def initialize vapp
      [:name, :status, :deployed, :id, :Description].each do |key|
        instance_variable_set("@#{key.downcase}", vapp[key])
      end

      @network_config = extract_network_config(vapp[:NetworkConfigSection][:NetworkConfig])
      @network_section = vapp[:'ovf:NetworkSection'][:'ovf:Network']
      @vms = Walk::Vms.new(vapp[:Children][:Vm])

    end

    private

    def extract_network_config network_configs
      (network_configs.is_a?(Hash) ? [network_configs] : network_configs).collect do |network_config|
        {
            network_name: network_config[:networkName],
            is_deployed: network_config[:IsDeployed],
            description: network_config[:Description],
            config: {
                ipscopes: network_config[:Configuration][:IpScopes]
            },
            parent_network: network_config[:Configuration][:ParentNetwork] ? network_config[:Configuration][:ParentNetwork][:name] : nil
        }
      end
    end

  end

  class VApps < Collection
    def initialize ids
      ids.each do |vapp_id|
        vapp = VcloudSession.get_vapp(vapp_id)
        self << Walk::VApp.new(vapp)
      end
    end
  end
end

