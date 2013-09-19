require_relative '../spec_helper'
require 'rspec/mocks'

module Walk

  class TestData < Entity
    attr_accessor :name

    def initialize data
      self.name = data.name
    end
  end

  class TestDataCollection < Collection
    def initialize coll
      coll.each do |c|
        self << Walk::TestData.new(c)
      end
    end

  end

  class TestClass < Entity
    attr_accessor :test_data
    attr_accessor :description

    def initialize test
      self.test_data = TestDataCollection.new(test.collection)
      self.description = test.description
    end
  end

end

describe Walk::Entity do
  it 'should be able to nested collections inside entities' do
    collection = [ mock(:name => 'collection 1'), mock(:name => 'collection 2') ]
    test_class = Walk::TestClass.new(mock(:description => 'test class desc', :collection => collection))

    test_class.to_summary.should == {:test_data=>[ {:name=>"collection 1"}, {:name=>"collection 2"}], :description=>"test class desc"}
  end
end
