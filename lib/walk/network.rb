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
    attr_accessor :id, :name, :description

    def initialize org_network
      self.id = org_network.id
      self.name = org_network.name
      self.description = org_network.description
    end

  end

end


