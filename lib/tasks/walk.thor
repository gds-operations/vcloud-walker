require 'thor'
require 'json'
require 'fog'
Dir[File.expand_path("../../**/*.rb", __FILE__)].each {|f| require f }

class Walk < Thor
  map "-L" => :list

  desc "catalogs", "describe all catalogs within given organization"
  def catalogs organization_id
    catalogs = ::Walk::Catalog.new(organization_id).show
    print_json catalogs
  end

  desc "vdcs", "describe all vdcs within given organization"   # [4]
  def vdcs organization_id
    vdcs = ::Walk::Vdc.new(organization_id).show
    print_json vdcs
  end

  desc "networks", "describe all networks within given organization"   # [4]
  def networks organization_id
    networks = ::Walk::Network.new(organization_id).show
    print_json networks
  end

  private
  def print_json vcloud_entity
    print JSON.pretty_generate(vcloud_entity)
  end
end

