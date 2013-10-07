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

  def self.get_edge_gateways
    org = get_org
    org.vdcs.all(false).collect do |vdc|
      vdc.edgeGateways.all(false)
    end.flatten
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