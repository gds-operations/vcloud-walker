module Walk

  class EdgeGateways < Walk::Collection

    def initialize(fog_gateways)
      fog_gateways.each do |edge_gateway|
        self << Walk::EdgeGateway.new(edge_gateway)
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


