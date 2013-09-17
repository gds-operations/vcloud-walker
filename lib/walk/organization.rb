module Walk
  class Organization < Entity

    attr_accessor :vdcs

    def self.get_by_id id
      session = VcloudSession.instance
      session.organizations.get_by_name(id)
    end
  end
end

