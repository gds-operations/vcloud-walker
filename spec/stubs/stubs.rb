class StubVdc
  @edge_gateways

  def initialize
    @edge_gateways = []
    @vapps = []
    @description = 'vdc-1-description'
  end

  def edge_gateways(edge_gateways)
    @edge_gateways = edge_gateways
    self
  end

  def vapps(vapps)
    @vapps = vapps
    self
  end

  def desc(desc)
    @description = desc
    self
  end

  def build
    vdc = RSpec::Mocks::Mock.new(:vdc,
                                 :id => 'vdc-1',
                                 :description => @description,
                                 :name => 'atomic reactor data centre',
                                 :network_quota => 20,
                                 :nic_quota => 0,
                                 :vm_quota => 150,
                                 :compute_capacity => {:storage => '200'}
    )
    vdc.stub(:edgeGateways).and_return(Fog::MockCollection.new(@edge_gateways))
    vdc.stub(:vapps).and_return(Fog::MockCollection.new(@vapps))
    vdc
  end
end


class StubCollectionBuilders
  def self.vdcs(vdc)
    RSpec::Mocks::Mock.new('Fog::Compute::VcloudDirector::Vdcs', :all => [vdc])
  end
end

module Fog
  class MockCollection
    def initialize collection
      @collection = collection
    end

    def all lazy_load
      @collection
    end

    def map &blk
      @collection.map(&blk)
    end
  end
end

