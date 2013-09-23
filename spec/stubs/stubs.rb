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
    vdc.stub(:edgeGateways).and_return(RSpec::Mocks::Mock.new(:all => @edge_gateways))
    vdc.stub(:vapps).and_return(RSpec::Mocks::Mock.new(:all => @vapps))
    vdc
  end
end


class StubCollectionBuilders
  def self.vdcs(vdc)
    RSpec::Mocks::Mock.new('Fog::Compute::VcloudDirector::Vdcs', :all => [vdc])
  end

  #def networks(networks)
  #  Rspec::Mocks::Mock.new('network')
  #end


end

