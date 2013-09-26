module Walk
  class VApp < Entity
    attr_reader :name, :status, :description, :network_config, :vms, :deployed, :network_section

    def initialize vapp
      @name = vapp.name
      @status = vapp.status
      @description = vapp.description
      @deployed = vapp.deployed
      @network_config = extract_network_config(vapp.network_config)
      @network_section = vapp.network_section
      @vms = Walk::Vms.new(vapp.vms.all(false))
    end

    private
    def extract_network_config network_configs
      (network_configs.is_a?(Hash)? [network_configs] : network_configs).collect do |network_config|
        {
            network_name: network_config[:networkName],
            is_deployed: network_config[:IsDeployed],
            description: network_config[:Description],
            config: {
                ipscopes: network_config[:Configuration][:IpScopes]
            },
            parent_network: network_config[:Configuration][:ParentNetwork]? network_config[:Configuration][:ParentNetwork][:name]: nil
        }
      end
    end

  end

  class VApps < Collection
    def initialize vapps
      vapps.each do |v|
        self << Walk::VApp.new(v)
      end
    end
  end
end

