module Walk
  class VApp < Entity
    attr_accessor :name, :status, :description, :network_config, :vms

    def initialize vapp
      self.name = vapp.name
      self.status = vapp.status
      self.description = vapp.description
      self.network_config = extract_network_config(vapp.network_config)
      self.vms = Walk::Vms.new(vapp.vms.all(false))
    end

    private
    def extract_network_config network_config
      {
          network_name: network_config[:networkName],
          is_deployed: network_config[:IsDeployed],
          description: network_config[:Description],
          config: {
              ipscopes: network_config[:Configuration][:IpScopes]
          },
          parent_network: network_config[:Configuration][:ParentNetwork][:name]
      }
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

