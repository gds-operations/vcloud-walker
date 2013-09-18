module Walk

  class Networks < Walk::Collection

    def initialize(organisation_id)
      org = Organization.get_by_id(organisation_id)
      org.networks.all(false).each do |org_network|
        self << Walk::Network.new(org_network)
      end
    end

  end


  class Network < Entity
    attr_accessor :id, :name, :description, :is_inherited, :gateway, :netmask, :dns1, :dns2, :dns_suffix, :ip_ranges

    def initialize org_network
      self.id = org_network.id
      self.name = org_network.name
      self.description = org_network.description
      self.is_inherited = org_network.is_inherited
      self.gateway = org_network.gateway
      self.netmask = org_network.netmask
      self.dns1 = org_network.dns1
      self.dns2 = org_network.dns2
      self.dns_suffix = org_network.dns_suffix
      self.ip_ranges = org_network.ip_ranges
    end

  end

end


