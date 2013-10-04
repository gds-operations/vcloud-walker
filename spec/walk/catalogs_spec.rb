require_relative '../spec_helper'
require 'rspec/mocks'

describe Walk::Catalogs do

    it "should summarize catalogs" do
      set_login_credential
      mock_item = double(:catalog_item,
                       :id => "12345",
                       :name => 'ubuntu 11.04',
                       :description => 'image for ubuntu 11.04',
                       :vapp_template_id => 'vapp-template-01')
      mock_catalog = double(:catalog,
                          :id => 'catalog_id_1',
                          :name => 'Default catalog',
                          :description => 'default catalog for infrastructure',
                          :catalog_items => double(:catalog_items, :all => [mock_item]))

      catalog_summary = Walk::Catalogs.new([mock_catalog]).to_summary
      catalog_summary.count.should == 1
      catalog_summary.first[:items].count.should == 1
      catalog_summary.should == [{
                                     :id => "catalog_id_1",
                                     :name => "Default catalog",
                                     :description => "default catalog for infrastructure",
                                     :items => [
                                         {:id => "12345", :name => "ubuntu 11.04", :description => "image for ubuntu 11.04", :vapp_template_id => "vapp-template-01"}
                                     ]
                                 }]
    end
end
