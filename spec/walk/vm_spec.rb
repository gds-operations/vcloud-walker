require 'spec_helper'

describe Vcloud::Walker::Resource::Vm do

  context 'populate summary vm model' do
    before(:all) do
      fog_vm = {
          :deployed => "true",
          :status => "8",
          :name => "ubuntu-testing-template",
          :id => "urn:vcloud:vm:aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee",
          :"ovf:VirtualHardwareSection" =>
              {:"ovf:Info" => "Virtual hardware requirements",
               :"ovf:System" => {:"vssd:ElementName" => "Virtual Hardware Family", :"vssd:VirtualSystemType" => "vmx-08"},
               :'ovf:Item' => Fog::ServiceLayerStub.hardware_resources
              },
          :"ovf:OperatingSystemSection" =>
              {
                  :vmw_osType => "ubuntu64Guest",
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
                              :MACAddress => "00:50:56:01:0c:30",
                              :IpAddressAllocationMode => "MANUAL"
                          }
                      ]
              },
          :RuntimeInfoSection => {:VMWareTools => {:version => "2147483647"}},
          :StorageProfile=>
              {
                  :type=>"application/vnd.vmware.vcloud.vdcStorageProfile+xml",
                  :name=>"TEST-STORAGE-PROFILE",
                  :href=>"https://api.vcd.portal.skyscapecloud.com/api/vdcStorageProfile/00000000-aaaa-bbbb-aaaa-000000000000"
              }
      }

      @vm_summary = Vcloud::Walker::Resource::Vm.new(fog_vm)
    end

    it "should populate vmware tool version" do
      @vm_summary.vmware_tools.should == {:version => "2147483647"}
    end

    it "should populate virtual system type" do
      @vm_summary.virtual_system_type.should == "vmx-08"
    end

    it "should populate operating system" do
      @vm_summary.operating_system.should == 'Ubuntu Linux (64-bit)'
    end

    it "should populate network connection interface" do
      @vm_summary.primary_network_connection_index.should == '0'
      @vm_summary.network_connections.count.should == 1
      @vm_summary.network_connections.first[:network].should == 'Default'
    end

    context "hardware resource info" do

      it "report cpu" do
        @vm_summary.cpu.should == '2 virtual CPU(s)'
      end

      it "report memory" do
        @vm_summary.memory.should == '4096 MB of memory'
      end

      it "report disk info" do
        @vm_summary.disks.count.should == 2
        @vm_summary.disks.first.should == {:name => "Hard disk 1", :size => 11265}
        @vm_summary.disks.last.should == {:name => "Hard disk 2", :size => 307200}
      end
    end
  end
end

