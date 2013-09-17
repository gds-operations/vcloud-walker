module Walk
  class Catalog < Entity

    attr_accessor :id, :name, :description, :items
    def initialize(catalog)
      self.id = catalog.id
      self.name = catalog.name
      self.description = catalog.description
      self.items = CatalogItems.new(catalog.catalog_items.all(false))
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
