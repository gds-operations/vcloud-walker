module Walk
  class Vms < Collection
    def initialize fog_vams
      fog_vams = [fog_vams] unless fog_vams.is_a? Array
      fog_vams.each do |vm|
        self << Walk::Vm.new(vm)
      end
    end
  end


  class Vm < Entity
    attr_reader :id, :status, :cpu, :memory, :operating_system, :disks, :primary_network_connection_index

    def initialize fog_vm
      [:id, :status].each do |key|
        instance_variable_set("@#{key.downcase}", fog_vm[key])
      end
      @operating_system = fog_vm[:'ovf:OperatingSystemSection'][:'ovf:Description']
      @network_connections = fog_vm[:NetworkConnectionSection][:NetworkConnection] if fog_vm[:NetworkConnectionSection]
      @primary_network_connection_index = fog_vm[:NetworkConnectionSection][:PrimaryNetworkConnectionIndex]
      extract_compute_capacity fog_vm[:'ovf:VirtualHardwareSection'][:'ovf:Item']
    end

    private

    def extract_compute_capacity ovf_resources
      %w(cpu memory disks).each { |resource| send("extract_#{resource}", ovf_resources) } unless ovf_resources.empty?

    end

    def extract_cpu(resources)
      @cpu = resources.detect { |element| element[:'rasd:Description']=='Number of Virtual CPUs' }[:'rasd:ElementName']
    end

    def extract_memory(resources)
      @memory = resources.detect { |element| element[:'rasd:Description']=='Memory Size' }[:'rasd:ElementName']
    end

    def extract_disks(resources)
      disk_resources = resources.select { |element| element[:'rasd:Description']=='Hard disk' }

      @disks = disk_resources.collect do |d|
        {:name => d[:'rasd:ElementName'], :size => d[:'rasd:HostResource'][:'ns12_capacity'].to_i}
      end
    end

  end
end

