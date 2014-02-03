require 'spec_helper'
require 'fog'
require 'stringio'
require 'vcloud/walker'

#######################################################################################
#  The intention of these tests are to ensure we have confdence that our tooling will
#   function when used, and as integration tests to cover the areas that get mocked
#   and so to uncover assumptions on how we use the fog libraries.
#
#  They are not there to test fog - that is the job of the fog tests, though
#   this can be reconsidered if we get a of undetected bugs.
#
#  Most if not all edge cases should be caught by the unit tests or the Fog tests.
#
#  NB: These tests require that all EdgeGateways in the organization have the
#  following services configured with at least one rule:
#    NatService
#    LoadBalancerService
#
#  NB: Integration test also requires that at least one vApp is configured in
#  the organization, otherwise tests fail with insufficient coverage.
#


describe Vcloud::Walker do
  context 'walk an organization' do

    it 'should integrate with fog to get vdcs' do

      vdc_summaries = Vcloud::Walker.walk('vdcs').to_json

      # assert that there are atleast one item and that includes the essencial sections
      vdc_summaries.should have_json_path('0/id')
      vdc_summaries.should have_json_path('0/name')
      vdc_summaries.should have_json_path('0/vapps')
      vdc_summaries.should have_json_path('0/quotas')
      vdc_summaries.should have_json_path('0/compute_capacity')
    end

    it "should integrate with fog to get networks" do

      network_summary = Vcloud::Walker.walk('networks').to_json

      # assert that there are atleast one item and that includes the essencial sections
      network_summary.should have_json_path('0/id')
      network_summary.should have_json_path('0/name')
      network_summary.should have_json_path('0/ip_ranges')
      network_summary.should have_json_path('0/gateway')
    end

    it "should integrate with fog to get catalogs" do

      catalogs_summary = Vcloud::Walker.walk('catalogs')
      catalog_summary = catalogs_summary.detect{|c| !c[:items].empty? }.to_json

      # assert that there are atleast one item and that includes the essencial sections
      catalog_summary.should have_json_path('id')
      catalog_summary.should have_json_path('name')
      catalog_summary.should have_json_path('items')
      catalog_summary.should have_json_path('items/0/vapp_template_id')
    end

    it "should integrate with fog to get edge gateway data" do

      result = Vcloud::Walker.walk('edgegateways').to_json
      # assert that there are atleast one item and that includes the essencial sections
      result.should have_json_path('0/Configuration/EdgeGatewayServiceConfiguration/FirewallService')
      result.should have_json_path('0/Configuration/EdgeGatewayServiceConfiguration/NatService')
      result.should have_json_path('0/Configuration/EdgeGatewayServiceConfiguration/LoadBalancerService')
      result.should have_json_path('0/Configuration/GatewayInterfaces/GatewayInterface')
    end
  end
end
