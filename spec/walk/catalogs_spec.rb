require_relative '../spec_helper'
require 'rspec/mocks'

describe Walk::Catalogs do
    let(:org) { double(:fog_org, :id => '4-3-51-7942a4') }
    let(:organizations) { double(:get_by_name => org) }
    let(:session) { double(:fog_session, :organizations => organizations) }

    it "should walk catalogs within given org" do
      Fog::Compute::VcloudDirector.should_receive(:new).with(any_args()).once.and_return(session)

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

      org.should_receive(:catalogs).and_return(double(:all => [mock_catalog]))

      catalog_summary = Walk::Catalogs.new('4-3-51-7942a4').to_summary
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
