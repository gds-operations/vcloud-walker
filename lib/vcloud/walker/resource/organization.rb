module Vcloud
  module Walker
    module Resource
      class Organization < Entity
        def self.catalogs
          fog_catalogs = FogInterface.get_catalogs
          Catalogs.new(fog_catalogs).to_summary
        end

        def self.vdcs
          fog_vdcs = FogInterface.get_vdcs
          Vdcs.new(fog_vdcs).to_summary
        end

        def self.edgegateways
          FogInterface.get_edge_gateways
        end


        def self.networks
          fog_networks = FogInterface.get_networks
          Networks.new(fog_networks).to_summary
        end

        def self.organization
          {
            :vdcs         => vdcs,
            :networks     => networks,
            :catalogs     => catalogs,
            :edgegateways => edgegateways,
          }
        end

      end
    end
  end
end

