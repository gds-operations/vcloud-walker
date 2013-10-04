require File.expand_path("../../walk/walk.rb", __FILE__)

class VcloudWalk < Thor
  map "-L" => :list

  desc "catalogs", "describe all catalogs within given organization"
  def catalogs
    fog_catalogs = FogInterface.get_catalogs
    print_json Walk::Catalogs.new(fog_catalogs).to_summary
  end

  desc "vdcs", "describe all vdcs within given organization"
  def vdcs
    fog_vdcs = FogInterface.get_vdcs
    print_json ::Walk::Vdcs.new(fog_vdcs).to_summary
  end

  desc "networks", "describe all networks within given organization"
  def networks
    fog_networks = FogInterface.get_networks
    print_json ::Walk::Networks.new(fog_networks).to_summary
  end

  desc "edgegateways", "describe settings within edge gateways"
  def edgegateways
    fog_gateways = FogInterface.get_edge_gateways
    print_json ::Walk::EdgeGateways.new(fog_gateways).to_summary
  end

  private
  def print_json vcloud_entity
    print JSON.pretty_generate(vcloud_entity)
    vcloud_entity
  end

  def organization_id
    ENV['API_USERNAME'].split('@').last
  end
end



