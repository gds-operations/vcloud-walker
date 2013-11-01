require_relative '../spec_helper'

describe Walk::Organization do
  let(:organization) { Organization.new }
  it "should retrieve networks" do
    fog_networks = double(:fog_networks)
    FogInterface.should_receive(:get_networks).and_return(fog_networks)
    ::Walk::Networks.should_receive(:new).with(fog_networks).and_return(double(:walker_networks, :to_summary => [:network => "Network 1"]))
    ::Walk::Organization.networks.should == [:network => "Network 1"]
  end

  it "should retrieve catalogs" do
    fog_catalogs = double(:fog_catalogs)
    FogInterface.should_receive(:get_catalogs).and_return(fog_catalogs)
    ::Walk::Catalogs.should_receive(:new).with(fog_catalogs).and_return(double(:walker_catalogs, :to_summary => [:catalog => "Catalog 1"]))
    ::Walk::Organization.catalogs.should == [:catalog => "Catalog 1"]
  end

  it "should retrieve vdcs" do
    fog_vdcs = double(:fog_vdcs)
    FogInterface.should_receive(:get_vdcs).and_return(fog_vdcs)
    ::Walk::Vdcs.should_receive(:new).with(fog_vdcs).and_return(double(:walker_vdcs, :to_summary => [:vdc => "VDC 1"]))
    ::Walk::Organization.vdcs.should == [:vdc => "VDC 1"]
  end

  it "should retrieve edgegateways" do
    fog_edgegateways = [:edgegateway => 'Gateway 1']
    FogInterface.should_receive(:get_edge_gateways).and_return(fog_edgegateways)

    ::Walk::Organization.edgegateways.should == [:edgegateway => 'Gateway 1']
  end

  it "should retrive entire organization" do
    ::Walk::Organization.should_receive(:edgegateways).and_return([:edgegateway => 'Gateway 1'])
    ::Walk::Organization.should_receive(:vdcs).and_return([:vdc => "VDC 1"])
    ::Walk::Organization.should_receive(:catalogs).and_return([:catalog => "Catalog 1"])
    ::Walk::Organization.should_receive(:networks).and_return([:network => "Network 1"])

    ::Walk::Organization.all.should == {
        :vdcs => [{ :vdc => "VDC 1" }],
        :networks => [{ :network => "Network 1" }],
        :catalogs => [{ :catalog => "Catalog 1" }],
        :edgegateways => [{ :edgegateway => "Gateway 1" }]
    }
  end
end

