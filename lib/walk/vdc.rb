module Walk
  class Vdcs < Collection
    def initialize organisation_id
      org = Organization.get_by_id(organisation_id)
      org.vdcs.all(false).each do |vdc|
        self << Walk::Vdc.new(vdc)
      end
    end
  end


  class Vdc < Entity
    attr_reader :vapps, :id, :name ,:description, :quotas, :compute_capacity

    def initialize(vdc)
      @id = vdc.id
      @name = vdc.name
      @description = vdc.description
      @vapps = Walk::VApps.new(vdc.vapps.all(false))
      @quotas = { network: vdc.network_quota, nic: vdc.nic_quota, vm: vdc.vm_quota }
      @compute_capacity = vdc.compute_capacity
    end

    end

end





