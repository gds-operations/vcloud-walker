require File.expand_path("../../walk/walk.rb", __FILE__)

class VcloudWalk < Thor
  map "-L" => :list

  desc "catalogs", "describe all catalogs within given organization"
  def catalogs
    catalogs = ::Walk::Catalogs.new(organization_id).to_summary
    print_json catalogs
  end

  desc "vdcs", "describe all vdcs within given organization"   # [4]
  def vdcs
    vdcs = ::Walk::Vdcs.new(organization_id).to_summary
    print_json vdcs
  end

  desc "networks", "describe all networks within given organization"   # [4]
  def networks
    networks = ::Walk::Networks.new(organization_id).to_summary
    print_json networks
  end

  desc "edgegateways", "describe settings within edge gateways"
  def edgegateways
    edgegateways = ::Walk::EdgeGateways.new(organization_id).to_summary
    print_json edgegateways
  end

  private
  def print_json vcloud_entity
    print JSON.pretty_generate(vcloud_entity)
  end

  def organization_id
    ENV['API_USERNAME'].split('@').last
  end
end



