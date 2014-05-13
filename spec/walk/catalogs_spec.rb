require 'spec_helper'
require 'rspec/mocks'

describe Vcloud::Walker::Resource::Catalogs do

    it "should summarize catalogs" do
      set_login_credential
      mock_fog_item = double(
        :catalog_item,
        :id => "12345",
        :name => 'ubuntu 11.04',
        :description => 'image for ubuntu 11.04',
        :vapp_template_id => 'vapp-template-01'
      )
      mock_fog_catalog = double(
        :catalog,
        :id => 'catalog_id_1',
        :name => 'Default catalog',
        :description => 'default catalog for infrastructure',
        :catalog_items => double(:catalog_items, :all => [mock_fog_item])
      )
      catalog_summary = Vcloud::Walker::Resource::Catalogs.new([mock_fog_catalog]).to_summary
      expect(catalog_summary.count).to eq(1)
      expect(catalog_summary.first[:items].count).to eq(1)
      expect(catalog_summary).to eq([{
        :id => "catalog_id_1",
        :name => "Default catalog",
        :description => "default catalog for infrastructure",
        :items => [{
          :id => "12345",
          :name => "ubuntu 11.04",
          :description => "image for ubuntu 11.04",
          :vapp_template_id => "vapp-template-01"
        }],
      }])
    end

end
