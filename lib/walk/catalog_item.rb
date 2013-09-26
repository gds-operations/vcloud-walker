module Walk
  class CatalogItem < Entity
    attr_reader :id, :name, :description, :vapp_template_id

    def initialize item
      @id = item.id
      @name = item.name
      @description = item.description
      @vapp_template_id = item.vapp_template_id
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