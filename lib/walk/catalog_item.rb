module Walk
  class CatalogItem < Entity
    attr_accessor :id, :name, :description, :vapp_template_id

    def initialize item
      self.id = item.id
      self.name = item.name
      self.description = item.description
      self.vapp_template_id = item.vapp_template_id
    end
  end

  class CatalogItems < Collection
    def initialize items
      items.each do |i|
        self << Walk::CatalogItem.new(i)
      end
    end
  end

end