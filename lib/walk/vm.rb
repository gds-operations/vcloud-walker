module Walk
  class Vms < Collection
    def initialize vms
      vms.each do |vdc|
        self << Walk::Vm.new(vdc)
      end
    end
  end

  class Vm < Entity
    attr_accessor :id, :status, :ip_address, :cpu, :memory, :operating_system
    
    def initialize vm
      self.id = vm.id
      self.status = vm.status
      self.ip_address = vm.ip_address
      self.cpu = vm.cpu
      self.memory = vm.memory
      self.operating_system = vm.operating_system
      #self.disks = disk_summary(vm.disks.all(false))
    end

    private
    # fails to load disk summary due to huge object size
    #def disk_summary disks
    #  disks.collect do |disk|
    #    {
    #        address: disk.address,
    #        description: disk.description,
    #        name: disk.name,
    #        capacity: disk.capacity,
    #        resource_sub_type: dsik.resource_sub_type,
    #        resource_type: disk.resource_type,
    #        address_on_parent: disk.address_on_parent,
    #        parent: disk.parent
    #    }
    #  end
    #end
  end
end