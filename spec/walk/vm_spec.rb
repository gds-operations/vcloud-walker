require 'spec_helper'

describe Vcloud::Walker::Resource::Vm do

  context 'populate summary vm model' do
    before(:all) do
      fog_vm = {
          :deployed => "true",
          :status => "8",
          :name => "ubuntu-precise-201310041515",
          :id => "urn:vcloud:vm:c31ecfcf-5cb0-417c-958c-0d0180cf7e2a",
          :"ovf:VirtualHardwareSection" =>
              {:"ovf:Info" => "Virtual hardware requirements",
               :"ovf:System" => {:"vssd:ElementName" => "Virtual Hardware Family", :"vssd:VirtualSystemType" => "vmx-08"},
               :'ovf:Item' => []
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
                      {
                          :network => "Default",
                          :needsCustomization => "true",
                          :NetworkConnectionIndex => "0",
                          :IpAddress => "192.168.254.100",
                          :IsConnected => "true",
                          :MACAddress => "00:50:56:01:0c:30",
                          :IpAddressAllocationMode => "MANUAL"
                      }
              },
          :RuntimeInfoSection => {:VMWareTools => {:version => "2147483647"}}
      }

      @vm_summary = Vcloud::Walker::Resource::Vm.new(fog_vm)

    end

    it "should populate vmware tool version" do
      @vm_summary.vmware_tools.should == {:version => "2147483647"}
    end

    it "should populate virtual system type" do
      @vm_summary.virtual_system_type.should == "vmx-08"
    end
  end
end

