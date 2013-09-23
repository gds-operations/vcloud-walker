require_relative '../spec_helper'
require 'fog'
require 'rspec/mocks'

describe Walk::Vdcs do
  let(:org) { double(:fog_org, :id => '4-3-51-7942a4') }
  let(:organizations) { double(:orgs) }
  let(:api_session) { double(:fog_session, :organizations => organizations) }

  context 'vdcs' do

    it "should summarize vdc within given org" do
      Fog::Compute::VcloudDirector.should_receive(:new).with(any_args()).and_return(api_session)
      organizations.should_receive(:get_by_name).with("4-3-51-7942a4").and_return(org)
      org.should_receive(:vdcs).and_return(mock_vdcs)

      vdc_summary = Walk::Vdcs.new('4-3-51-7942a4').to_summary
      vdc_summary.should == [
          {:id => "vdc-1",
           :name => "atomic reactor data centre",
           :description => "vdc-1-description",
           :vapps => [
               {:name => "vapp-atomic-centre",
                :status => "on",
                :description => "hosts the atomic centre app",
                :deployed => true,
                :network_config => [{:network_name => nil, :is_deployed => nil, :description => nil,
                                     :config => {:ipscopes => nil}, :parent_network => nil}],
                :network_section => {"ovf_name" => "vdc_default_network"},
                :vms => [{:id => "vm-1", :status => "on", :ip_address => "192.100.1.0", :cpu => 4, :memory => 4096,
                          :operating_system => "Ubuntu Linux (64-bit)", :disks => {"Hard disk 1" => 51200},
                          :network => {:network => "Default", :mac_address => "00:50:56:01:09:44",
                                       :ip_address_allocation_mode => "MANUAL"}}]}],
           :quotas => {:network => 20, :nic => 0, :vm => 150}, :compute_capacity => {:storage => "200"}}]
    end

  private

  def mock_vdcs
    vapp = mock_vapp
    double('Fog::Compute::VcloudDirector::Vdcs', :all => [mock_vdc(vapp)])
  end

  def mock_vdc(vapp)
    double(:vdc,
           :id => 'vdc-1',
           :description => 'vdc-1-description',
           :name => 'atomic reactor data centre',
           :network_quota => 20,
           :nic_quota => 0,
           :vm_quota => 150,
           :compute_capacity => {:storage => '200'},
           :vapps => double('Fog::Compute::VcloudDirector::Vapps', :all => [vapp]))
  end


  def mock_vapp
    double(:vapp,
         :vms => double('Fog::Compute::VcloudDirector::Vms',
                      :all => [mock_vm],
         ),
         :name => "vapp-atomic-centre",
         :status => 'on',
         :description => 'hosts the atomic centre app',
         :network_config => {
             network_name: 'Default',
             is_deployed: true,
             :description => 'the default vapp network',
             :Configuration => {},
             parent_network: 'Default'},
         :deployed => true,
         :network_section => {'ovf_name' => 'vdc_default_network'},

    )
  end

  def mock_vm
    double('Fog::Compute::VcloudDirector::Vm',
         :id => 'vm-1',
         :status => 'on',
         :ip_address => '192.100.1.0',
         :cpu => 4,
         :memory => 4096,
         :operating_system => 'Ubuntu Linux (64-bit)',
         :hard_disks => {"Hard disk 1" => 51200},
         :network => double(:network,
                          :network => 'Default',
                          :mac_address => '00:50:56:01:09:44',
                          :ip_address_allocation_mode => 'MANUAL'
         )
    )
  end
  end
end