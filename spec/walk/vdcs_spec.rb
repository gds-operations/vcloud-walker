require 'spec_helper'
require 'fog'
require 'rspec/mocks'

describe Vcloud::Walker::Resource::Vdcs do
  let(:api_session) { double(:fog_session) }

  context 'vdcs' do

    it "should summarize vdcs" do
      Fog::Compute::VcloudDirector.should_receive(:new).with(any_args()).and_return(api_session)

      mock_fog_vdcs = StubCollectionBuilders.vdcs(StubVdc.new.vapps([mock_vapp]).build)
      api_session.should_receive(:get_vapp).with(1).and_return(Fog::ServiceLayerStub.mock_vapp)

      vdcs_summary = Vcloud::Walker::Resource::Vdcs.new(mock_fog_vdcs).to_summary
      vdc_summary = vdcs_summary.first
      vdc_summary[:vapps].count.should == 1
      vdc_summary[:vapps].first[:vms].count == 1
    end

    private

    def mock_vapp
      double(:vapp, :id => 1)
    end

    def mock_vm
      double('Fog::Compute::VcloudDirector::Vm',
             :id => 'vm-1',
             :status => 'on',
             :ip_address => '192.100.1.0',
             :cpu => 4,
             :memory => 4096,
             :operating_system => 'Ubuntu Linux (64-bit)',
             :hard_disks => [{"Hard disk 1" => 51200}],
             :network => double(:network,
                                :network => 'Default',
                                :mac_address => '00:50:56:01:09:44',
                                :ip_address_allocation_mode => 'MANUAL',
                                :network_connections => [:connection_1, :connection2])
      )
    end
  end
end