require 'unit/spec_helper'

module Vcloud
  module Walker
    module Resource

      class TestData < Entity
        attr_accessor :name

        def initialize data
          self.name = data.name
        end
      end

      class TestDataCollection < Collection
        def initialize coll
          coll.each do |c|
            self << Vcloud::Walker::Resource::TestData.new(c)
          end
        end

      end

      class TestClass < Entity
        attr_accessor :test_data
        attr_accessor :description

        def initialize test
          self.test_data   = TestDataCollection.new(test.collection)
          self.description = test.description
        end
      end

    end
  end

  describe Vcloud::Walker::Resource::Entity do
    it 'should be able to nested collections inside entities' do
      collection = [double(:name => 'collection 1'), double(:name => 'collection 2')]
      test_class = Vcloud::Walker::Resource::TestClass.new(double(:description => 'test class desc', :collection => collection))

      test_class.to_summary.should == {:test_data => [{:name => "collection 1"}, {:name => "collection 2"}], :description => "test class desc"}
    end

    it 'should summaries a class as a hash and remove @ from the symbol names' do
      collection = [double(:name => 'collection 1'), double(:name => 'collection 2')]
      test_class = Vcloud::Walker::Resource::TestClass.new(double(:description => 'test class desc', :collection => collection))
      test_class.instance_variables.should eq([:@test_data, :@description])
      test_summary = test_class.to_summary
      test_summary.keys.should eq([:test_data, :description])
    end

  end
end


