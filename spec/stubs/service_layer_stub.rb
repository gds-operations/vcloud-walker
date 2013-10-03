module Fog
  module ServiceLayerStub
    def self.mock_vapp
      body = {:name => "vapp-atomic-centre",
              :id => 1,
              :status => "on",
              :description => "hosts the atomic centre app",
              :deployed => true,
              :NetworkConfigSection => {:NetworkConfig => [{:networkName => "Default", :IsDeployed => true, :Description => "default network",
                                                            :Configuration => {:IpScopes => 'abc'}, :ParentNetwork => nil}]},
              :"ovf:NetworkSection" => {:'ovf:Network' => 'network'},
              :Children => {
                  :Vm =>
                      {
                          :needsCustomization => "true",
                          :deployed => "true",
                          :status => "4", :name => "ubuntu-precise-201309091031",
                          :id => "urn:vcloud:vm:d19d84a5-c950-4497-a638-23eccc4226a5",
                          :type => "application/vnd.vmware.vcloud.vm+xml",
                          :href => "https://api.vcd.portal.skyscapecloud.com/api/vApp/vm-d19d84a5-c950-4497-a638-23eccc4226a5",
                          :Description => "ubuntu-precise | Version: 1.0 | Built using BoxGrinder",
                          :"ovf:OperatingSystemSection" =>
                              {
                                  :"ovf:Description" => "Ubuntu Linux (64-bit)",
                              },
                          :NetworkConnectionSection => {
                              :ovf_required => "false",
                              :"ovf:Info" => "Specifies the available VM network connections",
                              :PrimaryNetworkConnectionIndex => "0",
                              :NetworkConnection =>
                                  {
                                      :network => "Default",
                                      :needsCustomization => "true",
                                      :NetworkConnectionIndex => "0",
                                      :IpAddress => "192.168.2.2",
                                      :IsConnected => "true",
                                      :MACAddress => "00:50:56:01:0b:1a",
                                      :IpAddressAllocationMode => "MANUAL"},

                          },
                          :'ovf:VirtualHardwareSection' => {:'ovf:Item' => []}
                      }
              }
      }
      RSpec::Mocks::Mock.new(:fog_vapp, :body => body)
    end
  end
end
