module Walk
  class Network

    def initialize(organisation_id)
      session = VcloudSession.instance
      @org = session.organizations.get_by_name(organisation_id)
    end

    def show
      @org.networks.all(false).collect { |org_network| {id: org_network.id, name: org_network.name, description: org_network.description } }
    end

  end
end


