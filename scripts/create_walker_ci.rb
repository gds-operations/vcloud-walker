require File.expand_path("../../lib/walk/walk.rb", __FILE__)

def attach_vm_to_network vm
  network = vm.network
  network.network_connections[0][:network] = 'Default'
  network.network_connections[0][:ip_address] = '192.168.2.2'
  network.network_connections[0][:ip_address_allocation_mode] = 'MANUAL'
  network.network_connections[0][:is_connected] = true
  network.save
end

def create_vapp vdc, network, template
  options = { vdc_id: vdc.id,
              network_id: network.id }
  template.instantiate(vdc,'vcloud-walker-contract-testing-vapp', options)
  vapp = vdc.vapps.get_by_name('vcloud-walker-contract-testing-vapp')
  vm = vapp.vms.first
  attach_vm_to_network vm
  vapp.power_on
end

org = Walk::Organization.get_by_id('4-3-51-7942a4')
network = org.networks.get_by_name('Default')
catalog = org.catalogs.get_by_name('walker-ci')
template = catalog.catalog_items.get_by_name('ubuntu-precise-201309091031')
vdc = org.vdcs.get_by_name('GDS Networking API Testing (IL0-DEVTEST-BASIC)')

create_vapp vdc, network, template







