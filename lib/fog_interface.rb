class FogInterface

  def self.get_catalogs
    org = get_org
    org.catalogs.all(false)
  end

  def self.get_vdcs
    org = get_org
    org.vdcs.all(false)
  end

  def self.get_networks
    org = get_org
    org.networks.all(false)
  end

  # we use the request here as we don't yet have a model for Edge Gateways
  def self.get_edge_gateways
    session = VcloudSession.instance
    get_vdcs.collect do |vdc|
      data = session.get_edge_gateways(vdc.id).body
      if data[:EdgeGatewayRecord]
        edge_gateways = data[:EdgeGatewayRecord].is_a?(Hash) ? [data[:EdgeGatewayRecord]] : data[:EdgeGatewayRecord]
        edge_gateways.map do |edgeGateway|
         session.get_edge_gateway(edgeGateway[:href].split('/').last).body
        end
      end
    end.flatten.compact
  end

  # service-layer
  def self.get_vapp vapp_id
    VcloudSession.instance.get_vapp(vapp_id).body
  end

  private
  def self.get_org
    session = VcloudSession.instance
    session.organizations.get_by_name(session.org_name)
  end

end