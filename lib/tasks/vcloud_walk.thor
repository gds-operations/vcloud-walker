require File.expand_path("../../walk/walk.rb", __FILE__)

class VcloudWalk < Thor
  map "-L" => :list

  desc "catalogs", "describe all catalogs within given organization"
  def catalogs
    print_json Walk::Organization.catalogs
  end

  desc "vdcs", "describe all vdcs within given organization"
  def vdcs
    print_json Walk::Organization.vdcs
  end

  desc "networks", "describe all networks within given organization"
  def networks
    print_json Walk::Organization.networks
  end

  desc "edgegateways", "describe settings within edge gateways"
  def edgegateways
    print_json Walk::Organization.edgegateways
  end

  desc "organization", "describes entire organization"
  def organization
    print_json Walk::Organization.all
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



