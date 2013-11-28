require 'fog'

edge_gateway_id = ARGV[0]
raise "please provide edgegateway id. usage: bx ruby ./configure_walker_ci_vse.rb <edgegateway-id>" unless edge_gateway_id

lb_config = {
    :IsEnabled => "true",
    :Pool => [],
    :VirtualServer => []
}

configuration = {
    :FirewallService =>
        {
            :IsEnabled => true,
            :DefaultAction => 'allow',
            :LogDefaultAction => false,
            :FirewallRule => []
        },
    :LoadBalancerService => lb_config,
    :NatService => {
        :IsEnabled => true,
        :nat_type => 'portForwarding',
        :Policy => 'allowTraffic',
        :NatRule => []
    }
}

vcloud = Fog::Compute::VcloudDirector.new
task = vcloud.post_configure_edge_gateway_services edge_gateway_id, configuration
vcloud.process_task(task.body)
