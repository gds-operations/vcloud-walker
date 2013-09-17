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
    attr_accessor :vapps, :id, :name ,:description

    def initialize(vdc)
      self.id = vdc.id
      self.name = vdc.name
      self.description = vdc.description
      @vapps = Walk::VApps.new(vdc.vapps.all(false))
    end

    end

end





