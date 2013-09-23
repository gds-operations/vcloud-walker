require_relative '../spec_helper'
require 'rspec/mocks'


describe Walk::Catalogs do
  let(:org) { double(:fog_org, :id => '4-3-51-7942a4') }
  let(:organizations) { double(:get_by_name => org) }
  let(:session) { double(:fog_session, :organizations => organizations) }


  it 'should handle a 2 edge gateway' do

    Fog::Compute::VcloudDirector.should_receive(:new).and_return(session)

    vdcs = StubCollectionBuilders.vdcs(StubVdc.new.edge_gateways([mock_fog_edge_gateway, mock_fog_edge_gateway]).build)

    org.should_receive(:vdcs).and_return(vdcs)

    edge_gateways = Walk::EdgeGateways.new('4-3-51-7942a4')
    edge_gateways.count.should == 2
  end


  it 'should handle a single edge gateway' do

    Fog::Compute::VcloudDirector.should_receive(:new).and_return(session)

    vdcs = StubCollectionBuilders.vdcs(StubVdc.new.edge_gateways([mock_fog_edge_gateway]).build)
    org.should_receive(:vdcs).and_return(vdcs)

    edge_gateways = Walk::EdgeGateways.new('4-3-51-7942a4')
    edge_gateways.count.should == 1
  end

  it 'should handle zero edge gateways' do

    Fog::Compute::VcloudDirector.should_receive(:new).and_return(session)

    vdcs = StubCollectionBuilders.vdcs(StubVdc.new.build)
    org.should_receive(:vdcs).and_return(vdcs)

    edge_gateways = Walk::EdgeGateways.new('4-3-51-7942a4')
    edge_gateways.count.should == 0
  end

  it 'should set name, id and configuration' do

    Fog::Compute::VcloudDirector.should_receive(:new).and_return(session)

    vdcs = StubCollectionBuilders.vdcs(StubVdc.new.edge_gateways([mock_fog_edge_gateway]).build)

    org.should_receive(:vdcs).and_return(vdcs)

    edge_gateways = Walk::EdgeGateways.new('4-3-51-7942a4')
    edge_gateways.first.id.should == 'edge_gateway_id_1'
    edge_gateways.first.name.should == 'edge_gateway_name'
    edge_gateways.first.configuration.should == 'edge_gateway_config'

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



