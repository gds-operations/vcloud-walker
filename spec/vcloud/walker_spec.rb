require 'spec_helper'

module Vcloud
  module Walker

    describe "walk" do

      context "pass correct resource calls" do

        it "should correctly pass catalogs" do
          test_array = [ "name" => "catalogs" ]
          Vcloud::Walker::Resource::Organization.stub(:catalogs).and_return(test_array)
          result_array = Vcloud::Walker.walk("catalogs")
          result_array.should include("name" => "catalogs")
        end

        it "should correctly pass vdcs" do
          test_array = [ "name" => "vdcs" ]
          Vcloud::Walker::Resource::Organization.stub(:vdcs).and_return(test_array)
          result_array = Vcloud::Walker.walk("vdcs")
          result_array.should include("name" => "vdcs")
        end

        it "should correctly pass networks" do
          test_array = [ "name" => "networks" ]
          Vcloud::Walker::Resource::Organization.stub(:networks).and_return(test_array)
          result_array = Vcloud::Walker.walk("networks")
          result_array.should include("name" => "networks")
        end

        it "should correctly pass edgegateways" do
          test_array = [ "name" => "edgegateways" ]
          Vcloud::Walker::Resource::Organization.stub(:edgegateways).and_return(test_array)
          result_array = Vcloud::Walker.walk("edgegateways")
          result_array.should include("name" => "edgegateways")
        end

        it "should correctly pass organization" do
          test_array = [ "name" => "organization" ]
          Vcloud::Walker::Resource::Organization.stub(:organization).and_return(test_array)
          result_array = Vcloud::Walker.walk("organization")
          result_array.should include("name" => "organization")
        end

      end

      context "invalid resources" do

        it "should reject input that is not a valid resouce" do
          result_array = Vcloud::Walker.walk("invalid")
          result_array.should be_nil
        end

      end

    end

  end
end
