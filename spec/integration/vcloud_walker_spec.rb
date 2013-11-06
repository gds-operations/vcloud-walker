require_relative '../spec_helper'
require 'fog'
require 'stringio'

JsonSpec.directory = File.expand_path('../data/walker_ci', __FILE__)

#######################################################################################
#  The intention of these tests are to ensure we have confdence that our tooling will
#   function when used, and as integration tests to cover the areas that get mocked
#   and so to uncover assumptions on how we use the fog libraries.
#  They are not there to test fog - that is the job of the fog tests, though
#   this can be reconsidered if we get a of undetected bugs.
#  Most if not all edge cases should be caught by the unit tests or the Fog tests.
#

describe Walk::Vdcs do
  context 'walk an organization' do

    it 'should describe vdcs' do
      expected_summary = Data.Load('walker_ci', 'vdcs')

      vdc_summaries = VcloudWalk.new.vdcs
      vdc_summaries.count.should == 1

      vdc_summary = vdc_summaries.first

      [:vapps, :quotas, :name, :id, :description].each do |k|
        vdc_summary[k].to_json.should == expected_summary[k].to_json
      end

      vdc_summary[:compute_capacity].should_not be_nil
    end

    it "should describe networks" do
      expected = load_json('networks.json')

      network_summary = VcloudWalk.new.networks

      network_summary.to_json.should be_json_eql(expected)
    end

    it "should describe catalogs" do
      catalog_summary = VcloudWalk.new.catalogs

      expected_catalog_summary = load_json('catalogs.json')

      #comparing catalogs added by us, ignoring the skyscape public catalogs
      select_walker_ci_catalog(catalog_summary).to_json.should be_json_eql(expected_catalog_summary)
    end

    it "should integrate with fog to get edge gateway data" do

      result = VcloudWalk.new.edgegateways.first.to_json

      result.should have_json_path('Configuration/EdgeGatewayServiceConfiguration/FirewallService')
      result.should have_json_path('Configuration/EdgeGatewayServiceConfiguration/NatService')
      result.should have_json_path('Configuration/EdgeGatewayServiceConfiguration/LoadBalancerService')
      result.should have_json_path('Configuration/GatewayInterfaces/GatewayInterface')
    end

    private
    def select_walker_ci_catalog(catalog_summary)
      catalog_summary.select { |catalog| catalog[:name] == 'walker-ci' }
    end
  end
end
