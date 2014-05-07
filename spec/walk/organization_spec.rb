require 'spec_helper'

describe Vcloud::Walker::Resource::Organization do

  it "should retrieve networks" do
    fog_networks = double(:fog_networks)
    Vcloud::Walker::FogInterface.should_receive(:get_networks).and_return(fog_networks)
    Vcloud::Walker::Resource::Networks.should_receive(:new).with(fog_networks).
      and_return(double(:walker_networks, :to_summary => [:network => "Network 1"]))
    Vcloud::Walker::Resource::Organization.networks.should == [:network => "Network 1"]
  end

  it "should retrieve catalogs" do
    fog_catalogs = double(:fog_catalogs)
    Vcloud::Walker::FogInterface.should_receive(:get_catalogs).and_return(fog_catalogs)
    Vcloud::Walker::Resource::Catalogs.should_receive(:new).with(fog_catalogs).
      and_return(double(:walker_catalogs, :to_summary => [:catalog => "Catalog 1"]))
    Vcloud::Walker::Resource::Organization.catalogs.should == [:catalog => "Catalog 1"]
  end

  it "should retrieve vdcs" do
    fog_vdcs = double(:fog_vdcs)
    Vcloud::Walker::FogInterface.should_receive(:get_vdcs).and_return(fog_vdcs)
    Vcloud::Walker::Resource::Vdcs.should_receive(:new).with(fog_vdcs).
      and_return(double(:walker_vdcs, :to_summary => [:vdc => "VDC 1"]))
    Vcloud::Walker::Resource::Organization.vdcs.should == [:vdc => "VDC 1"]
  end

  it "should retrieve edgegateways" do
    fog_edgegateways = [{
      :id => 'urn:vcloud:gateway:1',
      :href => 'host/1',
      :name => 'Gateway 1',
      :Configuration => { :EdgeGatewayServiceConfiguration => {}}
    }]
    Vcloud::Walker::FogInterface.should_receive(:get_edge_gateways).
      and_return(fog_edgegateways)

    Vcloud::Walker::Resource::Organization.edgegateways.should == [{
      :id => '1',
      :name => 'Gateway 1',
      :href => 'host/1',
      :Configuration => { :EdgeGatewayServiceConfiguration => {} },
    }]
  end

  it "should retrive entire organization" do
    Vcloud::Walker::Resource::Organization.should_receive(:edgegateways).
      and_return([:edgegateway => 'Gateway 1'])
    Vcloud::Walker::Resource::Organization.should_receive(:vdcs).
      and_return([:vdc => "VDC 1"])
    Vcloud::Walker::Resource::Organization.should_receive(:catalogs).
      and_return([:catalog => "Catalog 1"])
    Vcloud::Walker::Resource::Organization.should_receive(:networks).
      and_return([:network => "Network 1"])

    Vcloud::Walker::Resource::Organization.organization.should == {
        :vdcs => [{ :vdc => "VDC 1" }],
        :networks => [{ :network => "Network 1" }],
        :catalogs => [{ :catalog => "Catalog 1" }],
        :edgegateways => [{ :edgegateway => "Gateway 1" }]
    }
  end

end

