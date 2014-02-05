require 'spec_helper'

describe Vcloud::Walker::Resource::GatewayIpsecVpnService do
  before(:all) do
    fog_vpn_service = {
      IsEnabled: true,
      Tunnel: {
        Name: "ss_one",
        Description: "desc one",
        IpsecVpnThirdPartyPeer: {
          PeerId: "1"
        },
        PeerIpAddress: "8.8.8.8",
        PeerId: "1",
        LocalIpAddress: "192.0.2.1",
        LocalId: "1",
        LocalSubnet: {
          Name: "Default",
          Gateway: "192.168.0.1",
          Netmask: "255.255.0.0"
        },
        PeerSubnet: {
          Name: "8.8.8.0/8",
          Gateway: "8.8.8.0",
          Netmask: "255.0.0.0"
        },
        SharedSecret: "DoNotDiscloseDoNotDiscloseDoNotDiscloseDoNotDiscloseDoNotDisclose",
        SharedSecretEncrypted: "false",
        EncryptionProtocol: "AES256",
        Mtu: "1500",
        AdditionalDetails: {
          shared_network: true
        },
        IsEnabled: "true",
        IsOperational: "false"
      }
    }

    @gateway_vpn_service = Vcloud::Walker::Resource::GatewayIpsecVpnService.new(fog_vpn_service)
  end
  it "should report status of vpn service" do
    expect(@gateway_vpn_service.IsEnabled).to eq(true)
    expect(@gateway_vpn_service.Tunnel).not_to be_nil
  end

  context "report tunnel info" do
    before(:all) do
      @tunnel = @gateway_vpn_service.Tunnel
    end

    it "with peer details" do
      expect(@tunnel[:PeerId]).to eq('1')
      expect(@tunnel[:PeerIpAddress]).to eq('8.8.8.8')
      expect(@tunnel[:PeerSubnet]).to eq({
                                           Name: "8.8.8.0/8",
                                           Gateway: "8.8.8.0",
                                           Netmask: "255.0.0.0"
                                         })
    end

    it "with local network details" do
      expect(@tunnel[:LocalId]).to eq('1')
      expect(@tunnel[:LocalIpAddress]).to eq('192.0.2.1')
      expect(@tunnel[:LocalSubnet]).to eq({
                                            Name: "Default",
                                            Gateway: "192.168.0.1",
                                            Netmask: "255.255.0.0"
                                          })
    end

    it "with maximum transmission unit" do
      expect(@tunnel[:Mtu]).to eq('1500')
    end

    it "should mark vpn shared secret information if present" do
      expect(@tunnel[:SharedSecret]).to eq("*" * 65)
      expect(@tunnel[:SharedSecretEncrypted]).to eq("******")
      expect(@tunnel[:EncryptionProtocol]).to eq("******")
    end
  end

end
