require_relative '../spec_helper'
require 'fog'
require 'rspec/mocks'

describe Walk::Vdcs do
  let(:org) { double(:fog_org, :id => '4-3-51-7942a4') }
  let(:organizations) { double(:orgs) }
  let(:api_session) { double(:fog_session, :organizations => organizations) }

  context 'vdcs' do

    it "should summarize vdc within given org" do
      Fog::Compute::VcloudDirector.should_receive(:new).twice.with(any_args()).and_return(api_session)
      organizations.should_receive(:get_by_name).with("4-3-51-7942a4").and_return(org)

      vdcs = StubCollectionBuilders.vdcs(StubVdc.new.vapps([mock_vapp]).build)
      org.should_receive(:vdcs).and_return(vdcs)
      api_session.should_receive(:get_vapp).with(1).and_return(Fog::ServiceLayerStub.mock_vapp)

      vdcs_summary = Walk::Vdcs.new('4-3-51-7942a4').to_summary
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