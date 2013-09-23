module Walk

  class EdgeGateways < Walk::Collection

    def initialize(organisation_id)
      org = Organization.get_by_id(organisation_id)
      org.vdcs.all(false).each do |vdc|
        vdc.edgeGateways.all(false).each do |edge_gateway|
        self << Walk::EdgeGateway.new(edge_gateway)
        end
      end
    end

  end

  class EdgeGateway < Entity
    attr_accessor :id, :configuration, :name

    def initialize edge_gateway
      self.id = edge_gateway.id
      self.name = edge_gateway.name
      self.configuration = edge_gateway.configuration
    end

  end

end


