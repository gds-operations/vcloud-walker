module Walk
  class Vms < Collection
    def initialize vms
      vms.each do |vdc|
        self << Walk::Vm.new(vdc)
      end
    end
  end

  class Vm < Entity
    attr_accessor :id, :status, :ip_address, :cpu, :memory, :operating_system, :disks
    
    def initialize vm
      self.id = vm.id
      self.status = vm.status
      self.ip_address = vm.ip_address
      self.cpu = vm.cpu
      self.memory = vm.memory
      self.operating_system = vm.operating_system
      self.disks = vm.hard_disks
    end

  end
end