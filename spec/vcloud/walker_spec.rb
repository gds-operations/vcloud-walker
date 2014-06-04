require 'spec_helper'

module Vcloud
  module Walker

    describe "walk" do

      context "pass correct resource calls" do

        it "should correctly pass catalogs" do
          test_array = [ "name" => "catalogs" ]
          allow(Vcloud::Walker::Resource::Organization).to receive(:catalogs).and_return(test_array)
          result_array = Vcloud::Walker.walk("catalogs")
          expect(result_array).to include("name" => "catalogs")
        end

        it "should correctly pass vdcs" do
          test_array = [ "name" => "vdcs" ]
          allow(Vcloud::Walker::Resource::Organization).to receive(:vdcs).and_return(test_array)
          result_array = Vcloud::Walker.walk("vdcs")
          expect(result_array).to include("name" => "vdcs")
        end

        it "should correctly pass networks" do
          test_array = [ "name" => "networks" ]
          allow(Vcloud::Walker::Resource::Organization).to receive(:networks).and_return(test_array)
          result_array = Vcloud::Walker.walk("networks")
          expect(result_array).to include("name" => "networks")
        end

        it "should correctly pass edgegateways" do
          test_array = [ "name" => "edgegateways" ]
          allow(Vcloud::Walker::Resource::Organization).to receive(:edgegateways).and_return(test_array)
          result_array = Vcloud::Walker.walk("edgegateways")
          expect(result_array).to include("name" => "edgegateways")
        end

        it "should correctly pass organization" do
          test_array = [ "name" => "organization" ]
          allow(Vcloud::Walker::Resource::Organization).to receive(:organization).and_return(test_array)
          result_array = Vcloud::Walker.walk("organization")
          expect(result_array).to include("name" => "organization")
        end

      end

      context "invalid resources" do
        it "should reject input that is not a valid resouce" do
          expect{ Vcloud::Walker.walk("invalid") }.
            to raise_error("Invalid resource 'invalid'. Possible options are 'catalogs','vdcs','networks','edgegateways','organization'.")
        end
      end

    end

  end
end
