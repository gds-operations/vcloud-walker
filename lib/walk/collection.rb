module Walk
  class Collection < Array
    def to_summary
      self.collect do |element|
         element.to_summary
      end
    end

  end
end