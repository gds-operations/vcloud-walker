require 'unit/spec_helper'
require 'rspec/mocks'

describe Vcloud::Walker::FogInterface do
  context "GET entities" do
    let(:org) { double(:fog_org, :id => 'org-123') }
    let(:organizations) { double(:orgs) }
    let(:session) { double(:fog_session, :org_name => 'org-123', :organizations => organizations) }

    before(:each) do
      Vcloud::Walker::VcloudSession.should_receive(:instance).with(any_args()).at_least(:once).and_return(session)
      organizations.should_receive(:get_by_name).and_return(org)
    end

    it "should get catalogs for given org id" do
      mock_catalogs = [double(:catalog1), double(:catalog2)]
      org.should_receive(:catalogs).and_return(double(:catalogs, :all => mock_catalogs))

      catalogs = Vcloud::Walker::FogInterface.get_catalogs

      catalogs.count.should == 2
      catalogs.should == mock_catalogs

    end

    it "should get networks for given org id" do
      mock_networks = [double(:network1), double(:network2)]
      org.should_receive(:networks).and_return(double(:networks, :all => mock_networks))

      networks = Vcloud::Walker::FogInterface.get_networks
      networks.count.should == 2
      networks.should == mock_networks
    end

    it "should get vdcs for given org id" do
      mock_vdcs = [double(:vdc1), double(:vdc2), double(:vdc3)]
      org.should_receive(:vdcs).and_return(double(:vdcs, :all => mock_vdcs))

      vdcs = Vcloud::Walker::FogInterface.get_vdcs
      vdcs.count.should == 3
      vdcs.should == mock_vdcs
    end

    it "should get edge gateways for given org" do
      mock_vdc1 = double(:vdc, :id => 1)
      get_edge_gateway_result = double('Excon::Response', :body => {:EdgeGatewayRecord => {:href => '/sausage'}})

      org.should_receive(:vdcs).and_return(double(:vdcs, :all => [ mock_vdc1 ]))
      session.should_receive(:get_org_vdc_gateways).with(1).and_return(get_edge_gateway_result)
      session.should_receive(:get_edge_gateway).with('sausage').and_return(double(:eg, :body => :eg1))

      edge_gateways = Vcloud::Walker::FogInterface.get_edge_gateways

      edge_gateways.count.should == 1
      edge_gateways.should == [:eg1]
    end

    it "should get edge gateways for given org with complex set up of 2 vdcs and 3 edge gateways" do
      mock_vdc1 = double(:vdc, :id => 1)
      get_edge_gateway_vdc_1_result = double('Excon::Response', :body => {:EdgeGatewayRecord => {:href => '/sausage'}})
      mock_vdc2 = double(:vdc, :id => 2)
      get_edge_gateway_vdc_2_result = double('Excon::Response', :body => {:EdgeGatewayRecord => [{:href => '/beans'}, {:href => '/hashbrown'}]})

      org.should_receive(:vdcs).and_return(double(:vdcs, :all => [ mock_vdc1, mock_vdc2 ]))

      session.should_receive(:get_org_vdc_gateways).with(1).and_return(get_edge_gateway_vdc_1_result)
      session.should_receive(:get_org_vdc_gateways).with(2).and_return(get_edge_gateway_vdc_2_result)
      session.should_receive(:get_edge_gateway).with('sausage').and_return(double(:eg, :body => :eg1))
      session.should_receive(:get_edge_gateway).with('beans').and_return(double(:eg, :body => :eg2))
      session.should_receive(:get_edge_gateway).with('hashbrown').and_return(double(:eg, :body => :eg3))

      edge_gateways = Vcloud::Walker::FogInterface.get_edge_gateways

      edge_gateways.count.should == 3
      edge_gateways.should == [:eg1, :eg2, :eg3]
    end

    it "get_edge_gateways should be happy if there are no edge gateways" do
      mock_vdc1 = double(:vdc, :id => 1)

      # no edge gateways means no entries to find in the results, just some other noise
      vdc_1_search_result = double('Excon::Response', :body => {:Link => {:href => 's'}})

      org.should_receive(:vdcs).and_return(double(:vdcs, :all => [ mock_vdc1 ]))
      session.should_receive(:get_org_vdc_gateways).with(1).and_return(vdc_1_search_result)

      edge_gateways = Vcloud::Walker::FogInterface.get_edge_gateways

      edge_gateways.count.should == 0
    end

  end
end