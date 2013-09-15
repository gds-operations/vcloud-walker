module Walk
  class Vdc
    def initialize(organisation_id)
      session = VcloudSession.instance
      @org = session.organizations.get_by_name(organisation_id)
    end

    def show
      @org.vdcs.all(false).collect do |vdc|
         {
             name: vdc.name,
             description: vdc.description,
             vapps:
                vdc.vapps.all(false).collect do |vapp|
                  vapp_summary(vapp)
                end
        }
      end
    end

    private
    def vapp_summary(vapp)
      {
          name: vapp.name,
          status: vapp.status,
          description: vapp.description,
          vms: vapp.vms.all(false).collect do |vm|
            vm_summary(vm)
          end

      }
    end

    def vm_summary(vm)
      {
          id: vm.id,
          status: vm.status,
          ip_address: vm.ip_address,
          cpu: vm.cpu,
          memory: vm.memory,
          operating_system: vm.operating_system,
          type: vm.type,
      }
    end

  end
end


