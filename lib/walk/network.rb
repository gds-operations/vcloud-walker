module Walk

  class Networks < Walk::Collection

    def initialize fog_networks
      fog_networks.each do |org_network|
        self << Walk::Network.new(org_network)
      end
    end

  end


  class Network < Entity
    attr_reader :id, :name, :description, :is_inherited, :gateway, :netmask, :dns1, :dns2, :dns_suffix, :ip_ranges

    def initialize org_network
      @id = org_network.id
      @name = org_network.name
      @description = org_network.description
      @is_inherited = org_network.is_inherited
      @gateway = org_network.gateway
      @netmask = org_network.netmask
      @dns1 = org_network.dns1
      @dns2 = org_network.dns2
      @dns_suffix = org_network.dns_suffix
      @ip_ranges = org_network.ip_ranges
    end

  end

end


