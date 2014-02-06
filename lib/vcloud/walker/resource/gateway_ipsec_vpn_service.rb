module Vcloud
  module Walker
    module Resource
      class GatewayIpsecVpnService < Entity
        attr_reader :IsEnabled, :Tunnels

        def initialize fog_vpn_service
          @IsEnabled = fog_vpn_service[:IsEnabled]
          if fog_vpn_service[:Tunnel]
            fog_vpn_tunnels = [fog_vpn_service[:Tunnel]].flatten
            @Tunnels = populate_tunnel_info(fog_vpn_tunnels)
          end
        end

        private
        def populate_tunnel_info(fog_vpn_tunnels)
          return if fog_vpn_tunnels.empty?
          fog_vpn_tunnels.collect do |fog_vpn_tunnel|
            @tunnel = {
              :Name => fog_vpn_tunnel[:Name],
              :Description => fog_vpn_tunnel[:Description],
              :ThirdPartyPeerId => fog_vpn_tunnel[:IpsecVpnThirdPartyPeer][:PeerId],
              :PeerId => fog_vpn_tunnel[:PeerId],
              :LocalId => fog_vpn_tunnel[:LocalId],
              :PeerIpAddress => fog_vpn_tunnel[:PeerIpAddress],
              :LocalIpAddress => fog_vpn_tunnel[:LocalIpAddress],
              :PeerSubnet => fog_vpn_tunnel[:PeerSubnet],
              :LocalSubnet => fog_vpn_tunnel[:LocalSubnet],
              :Mtu => fog_vpn_tunnel[:Mtu],
              :IsEnabled => fog_vpn_tunnel[:IsEnabled],
              :IsOperational => fog_vpn_tunnel[:IsOperational]
            }

            @tunnel[:SharedSecret] = "*" * 65 if fog_vpn_tunnel[:SharedSecret]
            @tunnel[:SharedSecretEncrypted] = "******" if fog_vpn_tunnel[:SharedSecretEncrypted]
            @tunnel[:EncryptionProtocol] = "******" if fog_vpn_tunnel[:EncryptionProtocol]
            @tunnel
          end
        end


      end

    end
  end
end
