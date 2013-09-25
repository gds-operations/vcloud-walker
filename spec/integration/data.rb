class Data
  def self.Load org_name, entity
    data_file = File.join(File.dirname(__FILE__), "/data/#{org_name}/#{entity}.json")
    JSON.parse(File.read(data_file),{:symbolize_names =>  true})
  end
end