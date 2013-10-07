module Walk
  class Vdcs < Collection

    def initialize fog_vdcs
      fog_vdcs.each do |vdc|
        self << Walk::Vdc.new(vdc)
      end
    end

  end


  class Vdc < Entity
    attr_reader :vapps, :id, :name, :description, :quotas, :compute_capacity

    def initialize(fog_vdc)
      @id = fog_vdc.id
      @name = fog_vdc.name
      @description = fog_vdc.description
      @vapps = Walk::VApps.new(fog_vdc.vapps.map(&:id))
      @quotas = {network: fog_vdc.network_quota, nic: fog_vdc.nic_quota, vm: fog_vdc.vm_quota}
      @compute_capacity = fog_vdc.compute_capacity
    end

  end

end





