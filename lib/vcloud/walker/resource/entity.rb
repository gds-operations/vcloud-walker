module Vcloud
  module Walker
    module Resource
      class Entity

        def to_summary
          h= {}
          instance_variables.each { |atr|
            atr_value = self.instance_variable_get(atr)
            if atr_value.is_a?(Vcloud::Walker::Resource::Collection)
              h[atr.to_s.delete("@").to_sym] = atr_value.to_summary
            else
              h[atr.to_s.delete("@").to_sym] = atr_value
            end
          }
          h
        end

        private
        def extract_id(href)
          href.split('/').last
        end

      end
    end
  end
end
