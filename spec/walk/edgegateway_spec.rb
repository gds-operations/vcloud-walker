require_relative '../spec_helper'
require 'rspec/mocks'

describe Walk::Catalogs do
  context "summary" do
    it 'should handle a 2 edge gateway' do
      edge_gateways = Walk::EdgeGateways.new([mock_fog_edge_gateway, mock_fog_edge_gateway])

      edge_gateways.count.should == 2
    end


    it 'should handle a single edge gateway' do
      edge_gateways = Walk::EdgeGateways.new([mock_fog_edge_gateway])

      edge_gateways.count.should == 1
    end

    it 'should handle zero edge gateways' do
      edge_gateways = Walk::EdgeGateways.new([])

      edge_gateways.count.should == 0
    end

    it 'should set name, id and configuration' do
      edge_gateways = Walk::EdgeGateways.new([mock_fog_edge_gateway])

      edge_gateways.first.id.should == 'edge_gateway_id_1'
      edge_gateways.first.name.should == 'edge_gateway_name'
      edge_gateways.first.configuration.should == 'edge_gateway_config'
    end
  end

  private
  def mock_fog_edge_gateway
    double(:fog_edgegateway,
           :id => 'edge_gateway_id_1',
           :name => 'edge_gateway_name',
           :configuration => 'edge_gateway_config'
    )
  end
end



