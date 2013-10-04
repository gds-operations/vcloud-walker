require_relative 'spec_helper'
require 'rspec/mocks'

describe FogInterface do
  context "GET entities" do
    let(:org) { double(:fog_org, :id => 'org-123') }
    let(:organizations) { double(:orgs) }
    let(:session) { double(:fog_session, :org_name => 'org-123', :organizations => organizations) }

    before(:each) do
      VcloudSession.should_receive(:instance).with(any_args()).and_return(session)
      organizations.should_receive(:get_by_name).and_return(org)
    end

    it "should get catalogs for given org id" do
      mock_catalogs = [double(:catalog1), double(:catalog2)]
      org.should_receive(:catalogs).and_return(double(:catalogs, :all => mock_catalogs))

      catalogs = FogInterface.get_catalogs

      catalogs.count.should == 2
      catalogs.should == mock_catalogs

    end

    it "should get networks for given org id" do
      mock_networks = [double(:network1), double(:network2)]
      org.should_receive(:networks).and_return(double(:networks, :all => mock_networks))

      networks = FogInterface.get_networks
      networks.count.should == 2
      networks.should == mock_networks
    end

    it "should get vdcs for given org id" do
      mock_vdcs = [double(:vdc1), double(:vdc2), double(:vdc3)]
      org.should_receive(:vdcs).and_return(double(:vdcs, :all => mock_vdcs))

      vdcs = FogInterface.get_vdcs
      vdcs.count.should == 3
      vdcs.should == mock_vdcs
    end

    it "should get edge gateways for given org id" do
      mock_gateways_for_vdc1 = [double(:gateway1), double(:gateway2)]
      mock_vdc1 = double(:vdc, :edgeGateways => double(:gateways, :all => mock_gateways_for_vdc1))

      mock_gateways_for_vdc2 = [double(:gateway3)]
      mock_vdc2 = double(:vdc, :edgeGateways => double(:gateways, :all => mock_gateways_for_vdc2))
      org.should_receive(:vdcs).and_return(double(:vdcs, :all => [ mock_vdc1, mock_vdc2 ]))

      edge_gateways = FogInterface.get_edge_gateways

      edge_gateways.count.should == 3
      edge_gateways.should == mock_gateways_for_vdc1 + mock_gateways_for_vdc2
    end
  end
end