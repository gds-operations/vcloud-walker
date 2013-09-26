module Walk
  class Vms < Collection
    def initialize vms
      vms.each do |vdc|
        self << Walk::Vm.new(vdc)
      end
    end
  end

  class Vm < Entity
    attr_reader :id, :status, :ip_address, :cpu, :memory, :operating_system, :disks, :network
    
    def initialize vm
      @id = vm.id
      @status = vm.status
      @ip_address = vm.ip_address
      @cpu = vm.cpu
      @memory = vm.memory
      @operating_system = vm.operating_system
      @disks = vm.hard_disks.collect { |disks_hash|
        disk = disks_hash.first
        {:name => disk.first, :size => disk.last}
      }
      @network = vm_network(vm.network) if vm.network
    end

    def vm_network(vm_network)
      {
          :network => vm_network.network,
          :mac_address => vm_network.mac_address,
          :ip_address_allocation_mode => vm_network.ip_address_allocation_mode
      } if vm_network
    end

  end
end