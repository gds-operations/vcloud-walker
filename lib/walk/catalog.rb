module Walk
  class Catalog

    def initialize(organisation_id)
      session = VcloudSession.instance
      @org = session.organizations.get_by_name(organisation_id)
    end

    def show
      @org.catalogs.all(false).collect do |catalog|
        new_catalog = {items: []}
        new_catalog.merge!({id: catalog.id, name: catalog.name, description: catalog.description})
        catalog.catalog_items.all(false).each do |catalog_item|
          new_catalog[:items] << {id: catalog_item.id, name: catalog_item.name, description: catalog_item.description}
        end
        new_catalog
      end
    end

  end
end
