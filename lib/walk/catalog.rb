module Walk
  class Catalog < Entity

    attr_reader :id, :name, :description, :items
    def initialize(catalog)
      @id = catalog.id
      @name = catalog.name
      @description = catalog.description
      @items = CatalogItems.new(catalog.catalog_items.all(false))
    end

  end

  class Catalogs < Collection
    def initialize organisation_id
      org = Organization.get_by_id(organisation_id)
      org.catalogs.all(false).each do |catalog|
        self << Walk::Catalog.new(catalog)
      end
    end
  end

end
