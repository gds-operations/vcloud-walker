module Walk
  class CatalogItem < Entity
    attr_reader :id, :name, :description, :vapp_template_id

    def initialize fog_catalog_item
      @id = fog_catalog_item.id
      @name = fog_catalog_item.name
      @description = fog_catalog_item.description
      @vapp_template_id = fog_catalog_item.vapp_template_id
    end
  end

  class CatalogItems < Collection
    def initialize fog_catalog_items
      fog_catalog_items.each do |i|
        self << Walk::CatalogItem.new(i)
      end
    end
  end

end