require 'spec_helper'

describe Vcloud::Walker::Resource::Vm do

  context 'populate summary vm model for 5.1' do
    before(:each) do
      fog_vm = assemble_sample_vm_data Fog::ServiceLayerStub.vcloud_director_five_one_ids

      @metadata = {:name => 'web-app-1', :shutdown => true}
      expect(Vcloud::Core::Vm).to receive(:get_metadata)
                      .with("vm-aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee")
                      .and_return(@metadata)

      @vm_summary = Vcloud::Walker::Resource::Vm.new(fog_vm)
    end

    it 'should report id from the href' do
      expect(@vm_summary.id).to eq('vm-aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee')
    end

    it "should populate vmware tool version" do
      expect(@vm_summary.vmware_tools).to eq({:version => "2147483647"})
    end

    it "should populate virtual system type" do
      expect(@vm_summary.virtual_system_type).to eq("vmx-08")
    end

    it "should populate operating system" do
      expect(@vm_summary.operating_system).to eq('Ubuntu Linux (64-bit)')
    end

    it "should populate network connection interface" do
      expect(@vm_summary.primary_network_connection_index).to eq('0')
      expect(@vm_summary.network_connections.count).to eq(1)
      expect(@vm_summary.network_connections.first[:network]).to eq('Default')
    end

    it "should populate storage profile" do
      expect(@vm_summary.storage_profile[:name]).to eq("TEST-STORAGE-PROFILE")
    end

    it "should populate storage profile id" do
      expect(@vm_summary.storage_profile[:id]).to eq("00000000-aaaa-bbbb-aaaa-000000000000")
    end

    context "hardware resource info" do

      it "report cpu" do
        expect(@vm_summary.cpu).to eq('2 virtual CPU(s)')
      end

      it "report memory" do
        expect(@vm_summary.memory).to eq('4096 MB of memory')
      end

      it "report disk info" do
        expect(@vm_summary.disks.count).to eq(2)
        expect(@vm_summary.disks.first).to eq({:name => "Hard disk 1", :size => 11265})
        expect(@vm_summary.disks.last).to eq({:name => "Hard disk 2", :size => 307200})
      end

      it "report network card info" do
        expect(@vm_summary.network_cards.count).to eq(1)
        expect(@vm_summary.network_cards[0]).to eq({
          :mac_address => '00:50:56:00:00:01',
          :name => "Network adapter 0",
          :type => "E1000"
        })
      end

    end

    it "report metadata" do
      expect(@vm_summary.metadata.count).to eq(2)
      expect(@vm_summary.metadata).to eq(@metadata)
    end

  end


  context 'populate summary vm model for 5.1 api on vcloud director 5.5' do
    before(:each) do
      fog_vm = assemble_sample_vm_data  Fog::ServiceLayerStub.vcloud_director_5_5_with_v5_1_api_ids

      @metadata = {:name => 'web-app-1', :shutdown => true}
      expect(Vcloud::Core::Vm).to receive(:get_metadata)
                      .with("vm-aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee")
                      .and_return(@metadata)

      @vm_summary = Vcloud::Walker::Resource::Vm.new(fog_vm)
    end

    it "report disk info for 5.1 api on 5.5" do
      expect(@vm_summary.disks.count).to eq(2)
      expect(@vm_summary.disks.first).to eq({:name => "Hard disk 1", :size => 11265})
      expect(@vm_summary.disks.last).to eq({:name => "Hard disk 2", :size => 307200})
    end

  end

  def assemble_sample_vm_data api_version
    {
      :deployed => "true",
      :status => "8",
      :name => "ubuntu-testing-template",
      :id => "urn:vcloud:vm:aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee",
      :href => 'https://myvdc.carrenza.net/api/vApp/vm-aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee',
      :"ovf:VirtualHardwareSection" =>
        {
          :"ovf:Info" => "Virtual hardware requirements",
          :"ovf:System" =>
            {
              :"vssd:ElementName" => "Virtual Hardware Family",
              :"vssd:VirtualSystemType" => "vmx-08"
            },
          :'ovf:Item' => Fog::ServiceLayerStub.hardware_resources(api_version)
        },
      :"ovf:OperatingSystemSection" =>
        {
          :vmw_osType  => "ubuntu64Guest",
          :"ovf:Info" => "Specifies the operating system installed",
          :"ovf:Description" => "Ubuntu Linux (64-bit)"
        },
      :NetworkConnectionSection =>
        {
          :type => "application/vnd.vmware.vcloud.networkConnectionSection+xml",
          :ovf_required => "false",
          :"ovf:Info" => "Specifies the available VM network connections",
          :PrimaryNetworkConnectionIndex => "0",
          :NetworkConnection =>
            [
              {
                :network => "Default",
                :needsCustomization => "true",
                :NetworkConnectionIndex => "0",
                :IpAddress => "192.168.254.100",
                :IsConnected => "true",
                :MACAddress => "00:50:56:00:00:01",
                :IpAddressAllocationMode => "MANUAL"
              },
            ]
        },
      :RuntimeInfoSection => {:VMWareTools => {:version => "2147483647"}},
      :StorageProfile =>
        {
          :type => "application/vnd.vmware.vcloud.vdcStorageProfile+xml",
          :name => "TEST-STORAGE-PROFILE",
          :href => "https://api.vcd.portal.examplecloud.com/api/vdcStorageProfile/00000000-aaaa-bbbb-aaaa-000000000000"
        }
    }
  end


end

