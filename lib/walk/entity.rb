module Walk
  class Entity
    def to_summary
      to_hash
    end

    private
    def to_hash
      h= {}
      instance_variables.each {|atr|
        atr_value = self.instance_variable_get(atr)
        if atr_value.is_a?(Walk::Collection)
          h[atr.to_s.delete("@").to_sym] = atr_value.to_summary
        else
          h[atr.to_s.delete("@").to_sym] = atr_value
        end
      }
      h
    end
  end

end