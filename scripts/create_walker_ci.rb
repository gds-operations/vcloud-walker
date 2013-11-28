require File.expand_path("../../lib/vcloud/walker.rb", __FILE__)

def attach_vm_to_network vm
  network = vm.network
  network.network_connections[0][:network] = 'Default'
  network.network_connections[0][:ip_address] = '192.168.254.100'
  network.network_connections[0][:ip_address_allocation_mode] = 'MANUAL'
  network.network_connections[0][:is_connected] = true
  network.save
end

def create_vapp vdc, network, template
  options = { vdc_id: vdc.id,
              network_id: network.id,
              :description => 'this app is used to run integration tests for vcloud-walker'}
  template.instantiate('vcloud-walker-contract-testing-vapp', options)
  vapp = vdc.vapps.get_by_name('vcloud-walker-contract-testing-vapp')
  vm = vapp.vms.first
  attach_vm_to_network vm
  vapp.power_on
end

org = Vcloud::Walker::FogInterface.get_org
network = org.networks.get_by_name('walker-ci-network')
catalog = org.catalogs.get_by_name('walker-ci')
template = catalog.catalog_items.get_by_name('walker-ci-template')
vdc = org.vdcs.get_by_name('0e7t-vcloud_tools_ci-OVDC-001')
create_vapp vdc, network, template







