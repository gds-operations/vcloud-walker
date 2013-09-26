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
    attr_reader :id, :configuration, :name

    def initialize edge_gateway
      @id = edge_gateway.id
      @name = edge_gateway.name
      @configuration = edge_gateway.configuration
    end

  end

end


