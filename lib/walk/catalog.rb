module Walk
  class Catalog < Entity
    attr_reader :id, :name, :description, :items

    def initialize(fog_catalog)
      @id = fog_catalog.id
      @name = fog_catalog.name
      @description = fog_catalog.description
      @items = CatalogItems.new(fog_catalog.catalog_items.all(false))
    end

  end

  class Catalogs < Collection

    def initialize fog_catalogs
      fog_catalogs.each do |catalog|
        self << Walk::Catalog.new(catalog)
      end
    end

  end

end
