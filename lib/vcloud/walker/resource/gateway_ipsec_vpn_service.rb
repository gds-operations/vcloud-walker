module Vcloud
  module Walker
    module Resource
      class GatewayIpsecVpnService < Entity
        attr_reader :enabled, :end_point, :tunnel

        def initialize fog_vpn_service
          @enabled = fog_vpn_service[:IsEnabled]
          @end_point = fog_vpn_service[:Endpoint] if fog_vpn_service[:Endpoint]
          @tunnel = Tunnel.new(fog_vpn_service[:Tunnel]) if fog_vpn_service[:Tunnel]
        end

      end

      class Tunnel < Entity
        attr_reader :name, :description, :third_party_peer_id, :peer_id, :local_id, :peer_ip_address,
                    :local_ip_address, :local_subnet, :peer_subnet, :mtu, :enabled, :operational,
                    :error

        def initialize fog_vpn_tunnel
          @name = fog_vpn_tunnel[:Name]
          @description = fog_vpn_tunnel[:Description]
          @third_party_peer_id = fog_vpn_tunnel[:IpsecVpnThirdPartyPeer][:PeerId]
          @peer_id = fog_vpn_tunnel[:PeerId]
          @peer_ip_address = fog_vpn_tunnel[:PeerIpAddress]
          @local_id = fog_vpn_tunnel[:LocalId]
          @local_ip_address = fog_vpn_tunnel[:LocalIpAddress]
          @peer_subnet = fog_vpn_tunnel[:PeerSubnet]
          @local_subnet = fog_vpn_tunnel[:LocalSubnet]
          @mtu = fog_vpn_tunnel[:Mtu]
          @enabled = fog_vpn_tunnel[:IsEnabled]
          @operational = fog_vpn_tunnel[:IsOperational]
        end
      end
    end
  end
end