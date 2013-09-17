require File.expand_path("../../walk/walk.rb", __FILE__)

class Walk < Thor
  map "-L" => :list

  desc "catalogs", "describe all catalogs within given organization"
  def catalogs organization_id
    catalogs = ::Walk::Catalogs.new(organization_id).to_summary
    print_json catalogs
  end

  desc "vdcs", "describe all vdcs within given organization"   # [4]
  def vdcs organization_id
    vdcs = ::Walk::Vdcs.new(organization_id).to_summary
    print_json vdcs
  end

  desc "networks", "describe all networks within given organization"   # [4]
  def networks organization_id
    networks = ::Walk::Networks.new(organization_id).to_summary
    print_json networks
  end

  private
  def print_json vcloud_entity
    print JSON.pretty_generate(vcloud_entity)
  end
end

